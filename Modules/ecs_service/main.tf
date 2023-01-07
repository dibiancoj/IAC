data "aws_subnets" "my_subnets" {
  filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }
}

data "aws_ecs_cluster" "ecs-cluster" {
  cluster_name = var.ecs_cluster_name
}

locals {
  //combine datadog items?
  combine_env_variables = concat(var.env_variables_for_container, [])
  # combine_env_variables = concat(var.env_variables_for_container, [
  #   {
  #     "name" : "DD_AGENT_HOST",
  #     "value" : "localhost"
  #   },
  #   {
  #     "name" : "DD_SERVICE_NAME",
  #     "value" : "${var.data_dog_application_name}"
  #   },
  #   {
  #     "name" : "DD_TRACE_AGENT_PORT",
  #     "value" : "8126"
  # }])
}

resource "aws_ecs_task_definition" "app" {
  family                   = "${var.application_name}-app-task"
  task_role_arn            = var.ecs_task_execution_role_arn
  execution_role_arn       = var.ecs_task_execution_role_arn
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.fargate_cpu
  memory                   = var.fargate_memory
  container_definitions = jsonencode([
    {
      name        = "${var.application_name}-app",
      image       = "${var.app_image_ecr_url}",
      cpu         = var.fargate_cpu,
      memory      = var.fargate_memory,
      networkMode = "awsvpc",
      //use the following when you bring file lens and fluent bit for more complicated scenarios
      # logConfiguration = {
      #   logDriver = "awsfirelens",
      #   options = {
      #     Name           = "datadog",
      #     Host           = "http-intake.logs.datadoghq.com",
      #     dd_service     = "${var.application_name}",
      #     dd_source      = "${var.application_name}",
      #     dd_message_key = "log",
      #     dd_tags        = "env:${var.data_dog_env_name}",
      #     TLS            = "on",
      #     provider       = "ecs",
      #   },
      #   secretOptions = [{
      #     name      = "apikey",
      #     valueFrom = "${var.data_dog_secret_api_key_arn}"
      #   }]
      # },
      logConfiguration = {
        logDriver = "awslogs",
        options = {
          awslogs-group         = "/ecs/${var.application_name}-app",
          awslogs-region        = "${var.ecs_region}",
          awslogs-stream-prefix = "ecs"
        }
      },
      portMappings : [
        {
          containerPort = var.app_port,
          hostPort      = var.app_port
        }
      ],
      environment : local.combine_env_variables
      secrets : var.secrets_for_container
    }

    # {
    #   name  = "${var.application_name}-data-dog-agent",
    #   image = "public.ecr.aws/datadog/agent:latest",
    #   logConfiguration = {
    #     logDriver = "awslogs",
    #     options = {
    #       awslogs-group         = "/ecs/${var.application_name}-app",
    #       awslogs-region        = "${var.ecs_region}",
    #       awslogs-stream-prefix = "ecs"
    #     }
    #   },
    #   portMappings : [
    #     {
    #       containerPort = 8126,
    #       hostPort      = 8126
    #       protocol      = "tcp"
    #     },
    #     {
    #       containerPort = 8125,
    #       protocol      = "udp"
    #     }
    #   ],
    #   environment : [
    #     {
    #       "name" : "DD_ENV",
    #       "value" : "${var.data_dog_env_name}"
    #     },
    #     {
    #       "name" : "DD_DOGSTATSD_NON_LOCAL_TRAFFIC",
    #       "value" : "true"
    #     },
    #     {
    #       "name" : "ECS_FARGATE",
    #       "value" : "true"
    #     },
    #     {
    #       "name" : "DD_APM_ENABLED",
    #       "value" : "true"
    #     },
    #     {
    #       "name" : "DD_APM_RECEIVER_PORT",
    #       "value" : "8126"
    #     },
    #     {
    #       "name" : "DD_DOGSTATSD_PORT",
    #       "value" : "8125"
    #     },
    #     {
    #       "name" : "DD_APM_NON_LOCAL_TRAFFIC",
    #       "value" : "true"
    #     }
    #   ]
    #   secrets : [
    #     {
    #       "name" : "DD_API_KEY",
    #       "valueFrom" : "${var.data_dog_secret_api_key_arn}"
    #     }
    #   ]
    # },
    # {
    #   essential = true,
    #   image     = "${var.fluent_bit_ecr_image}", //"814371004682.dkr.ecr.us-east-1.amazonaws.com/fluentbit:latest",
    #   name      = "log_router",
    #   # secrets =  [{
    #   # "name" : "API_KEY",
    #   # "valueFrom" : "${var.data_dog_secret_api_key_arn}"
    #   # }],
    #   firelensConfiguration = {
    #     type = "fluentbit",
    #     options = {
    #       enable-ecs-log-metadata = "false",
    #       config-file-type        = "file",
    #       config-file-value       = "/custom.conf"
    #     }
    #   },
    #   logConfiguration = {
    #     logDriver = "awslogs",
    #     options = {
    #       awslogs-group  = "/ecs/${var.application_name}-app",
    #       awslogs-region = "${var.ecs_region}",
    #       //awslogs-create-group = "false",
    #       awslogs-stream-prefix = "ecs"
    #     }
    #   }
    # },
  ])
}

resource "aws_ecs_service" "main" {
  name                  = "${var.application_name}-service"
  cluster               = data.aws_ecs_cluster.ecs-cluster.arn
  task_definition       = aws_ecs_task_definition.app.arn
  desired_count         = var.desired_container_count
  launch_type           = "FARGATE"
  wait_for_steady_state = true
  timeouts {
    update = var.timeout_for_deployments
  }

  lifecycle {
    create_before_destroy = true
  }

  network_configuration {
    security_groups  = [var.alb_security_group_id]
    subnets          = data.aws_subnets.my_subnets.ids //aws_subnet.private.*.id
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_alb_target_group.app.id
    container_name   = "${var.application_name}-app"
    container_port   = var.app_port
  }

  depends_on = [var.aws_iam_role_policy_attachment_arn]
}
