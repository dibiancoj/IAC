locals {
  vpc_id           = "vpc-5dd17e36"
  port_for_listner = 80
}

module "my_alb" {
  source = "../../Modules/alb"
  //source                       = "git::https://github.com/dibiancoj/IAC.git//Modules/alb"
  vpc_id                      = local.vpc_id
  alb_name                    = "my-alb"
  alb_is_internal_access_only = false
  app_port                    = local.port_for_listner
}

module "my_ecs_cluster" {
  source = "../../Modules/ecs_cluster"
  //source                       = "git::https://github.com/dibiancoj/IAC.git//Modules/ecs_cluster"
  cluster_name                 = "my_ecs_cluster"
  ecs_task_execution_role_name = "my_ecs_exec_role"
  permissions_boundary         = null
}

module "my_ecs_service" {
  source = "../../Modules/ecs_service"
  //source                       = "git::https://github.com/dibiancoj/IAC.git//Modules/ecs_service"
  vpc_id                             = local.vpc_id
  ecs_region                         = "us-east-2"
  application_name                   = "my-api-two"
  ecs_task_execution_role_arn        = module.my_ecs_cluster.ecs_task_execution_role_arn
  aws_iam_role_policy_attachment_arn = module.my_ecs_cluster.aws_iam_role_policy_attachment
  ecs_cluster_name                   = module.my_ecs_cluster.ecs_cluster_name
  app_image_ecr_url                  = "nginx:latest"
  alb_arn                            = module.my_alb.raw_alb.arn
  alb_security_group_id              = module.my_alb.raw_alb_security_group.id
  app_port                           = local.port_for_listner
  desired_container_count            = 2
  fargate_cpu                        = 1024
  fargate_memory                     = 2048
  timeout_for_deployments            = "10m"
  health_check_path                  = "/" //nginx doesn't have /health. Most of our stuff will have /health for a health check url
  env_variables_for_container = [{
    "name" : "MyKey",
    "value" : "MyValue"
  }]
  secrets_for_container = [
    #         {"name": "token",
    #         "valueFrom": "arn:aws:secretsmanager:us-east-1:814371004682:secret:user-portaldb-auth-hd7RPX:PORTAL_DB_USERNAME::"
    #       }
  ]
}

//add the alb listener (can only have 1 per port) to point to the target group (which is the ecs service)
resource "aws_alb_listener" "front_end" {
  load_balancer_arn = module.my_alb.raw_alb.arn
  port              = local.port_for_listner
  protocol          = "HTTP"

  default_action {
    target_group_arn = module.my_ecs_service.raw_alb_target_group.arn
    type             = "forward"
  }
}

output "cluster_name" {
  value = module.my_ecs_cluster.ecs_cluster_name
}

output "cluster_arn" {
  value = module.my_ecs_cluster.ecs_cluster_arn
}

output "cluster_attachment_policy" {
  value = module.my_ecs_cluster.aws_iam_role_policy_attachment
}

output "cluster_ecs_task_execution_role_arn" {
  value = module.my_ecs_cluster.ecs_task_execution_role_arn
}

output "alb_url" {
  value = module.my_alb.alb_hostname
}
