variable "vpc_id" {
  description = "Vpc Id"
  type        = string
}

variable "ecs_region" {
  description = "Region for the ecs cluster"
  default     = "us-east-1"
  type        = string
}

variable "timeout_for_deployments" {
  description = "The time it takes to fail when deployments keep failing and restarting containers"
  default     = "10m"
  type        = string
}

variable "application_name" {
  description = "Application name which is used for naming resources"
  type        = string
}

# variable "permissions_boundary" {
#   description = "The ARN of the policy that is used to set the permissions boundary for the role."
#   type        = string
# }

variable "ecs_task_execution_role_arn" {
  description = "ecs task execution role arn from the cluster"
  type        = string
}

variable "aws_iam_role_policy_attachment_arn" {
  description = "ecs policy attachment arn"
  type        = string
}

variable "ecs_cluster_name" {
  description = "Ecs cluster name"
  type        = string
}

# variable "ecs_auto_scale_role_name" {
#   description = "ECS auto scale role Name"
# }


variable "app_image_ecr_url" {
  description = "Docker image to run in the ECS cluster"
  type        = string
}

variable "desired_container_count" {
  description = "Number of docker containers to run"
  default     = 2
  type        = number
}

variable "fargate_cpu" {
  description = "Fargate instance CPU units to provision (1 vCPU = 1024 CPU units)"
  default     = 1024
  type        = number
}

variable "fargate_memory" {
  description = "Fargate instance memory to provision (in MiB)"
  default     = 2048
  type        = number
}

variable "health_check_path" {
  description = "Application health check url."
  type        = string
}

variable "app_port" {
  description = "Port to listena nd push traffic on"
  default     = 80
  type        = number
}

variable "alb_arn" {
  description = "Application load balancer arn to attach the target group to"
  type        = string
}

variable "alb_security_group_id" {
  description = "Alb security group arn to use"
  type        = string
}

variable "env_variables_for_container" {
  description = "Env variables to set in the container (non-secret env variables)"
  # default = [
  #       {
  #         "name": "PORT",
  #         "value": "80"
  #       },
  #       {
  #         "name": "token",
  #         "value": "xxxxx"
  #       }
  #     ]
}

variable "secrets_for_container" {
  description = "Secrets pulled from secret manager and pushed to the container in env variables (securely)"
  # default = [
  #       {
  #         "name": "token",
  #         "valueFrom": "arn:aws:secretsmanager:us-east-1:814371004682:secret:user-portaldb-auth-hd7RPX:PORTAL_DB_USERNAME::"
  #       }
  #     ]
}

# variable "data_dog_env_name" {
#   description = "Datadog env name. This will report to datadog which env your application is running"

#   validation {
#     condition     = contains(["dev", "test", "qa", "prod"], var.data_dog_env_name)
#     error_message = "Invalid datadog env name. Valid values for data_dog_env_name: (dev,test,qa,prod)."
#   }
# }

# variable "data_dog_application_name" {
#   description = "Datadog application name. Will display when looking for the application in datadog"
# }

# variable "data_dog_secret_api_key_arn" {
#   description = "Data dog secret for the api key."
# }

# variable "fluent_bit_ecr_image" {
#   description = "Fluent bit ecr image"
# }
