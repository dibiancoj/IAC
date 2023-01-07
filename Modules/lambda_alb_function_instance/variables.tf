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
  type        = string
}

variable "app_port" {
  description = "Application port"
  type        = number
}

variable "vpc_id" {
  description = "Vpc Id"
  type        = string
}

variable "alb_routing_rule_priority" {
  description = "Priority of the routing rules for each alb"
  type        = number
}

variable "alb_request_routing_by_request_header_name" {
  description = "Use to route based on a header value in the request. This field is the header name to look for"
  type        = string
}

variable "alb_request_routing_by_request_header_values" {
  description = "Use to route based on a header value in the request. This field is the header value to look for"
  type        = list(string)
}
