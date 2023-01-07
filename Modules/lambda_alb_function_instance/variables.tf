# variable "aws_alb_target_group_arn" {
#   type = string  
# }

variable "lambda_arn" {
  type = string
}

variable "lambda_function_name" {
  type = string
}

variable "aws_alb_listener_arn" {
  description = "Alb Listender Arn"
}

variable "alb_path" {
  description = "Path to invoke the lambda in the dns for alb"
}

variable "alb_path_priority" {
  description = "Priority of the routing rules for each alb"
  type        = number
}

variable "app_port" {
  description = "Application port"
}

variable "vpc_id" {
  description = "Vpc Id"
}
