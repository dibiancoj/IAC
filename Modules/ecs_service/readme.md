Version 1.0
 - Initial Release

***   

#### [Basic Example](https://github.com/dibiancoj/IAC/tree/main/ModuleTester/EcsClusterWithEcsServiceAndAlb)

##### 1 Ecs service with 1 alb

 ```
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

 ```

### More complex scenarios
- 2 Ecs services with 1 alb example is shown [here](https://github.com/dibiancoj/IAC/tree/main/ModuleTester/EcsClusterWith2EcsServiceAnd1Alb).

 #### Run:
- ```terraform init```
- ```terraform plan```
- ```terraform apply```
