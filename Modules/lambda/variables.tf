variable "lambda_zip_file_name" {
  type = string
}

variable "function_name" {
  type = string
}

variable "handler_namespace_path" {
  type = string
}

variable "runtime" {
  type = string
}

variable "subnets" {
  description = "Subnets"
}

variable "lambda_vpc_security_group_ids" {
  description = "Lambda vpc security group ids"
}

variable "env_variables" {
  description = "Env variables for lambda"
}

variable "iam_role_arn_for_lambda" {
  default = "Arn for the lambda role when executing"
}

variable "time_out" {
  description = "Lambda timeout"
}

variable "publish_version_of_lambda" {
  type        = bool
  description = "Create a version of the lambda"
}

variable "memory_size_in_mb" {
  type    = number
  default = 128
}
