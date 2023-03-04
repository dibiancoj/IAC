//will be 1 or the other. Either upload a file directly or push to an s3
variable "lambda_zip_file_name" {
  type        = string
  description = "File name with path. Used with direct upload or s3"
}

variable "lambda_s3_bucket" {
  type        = string
  description = "S3 bucket when used to upload lambda. Will be null when direct file upload is used"
  default = null
}

variable "lambda_s3_key" {
  type        = string
  description = "S3 bucket key when used to upload lambda. Will be null when direct file upload is used"
  default = null
}
//end of optional items

variable "function_name" {
  type = string
}

variable "subnet_ids" {
  description = "Subnet ids. Leave null if you don't want to put your lambda in a vpc"
}

variable "handler_namespace_path" {
  type = string
}

variable "runtime" {
  type = string
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

variable "time_out_in_seconds" {
  description = "Lambda timeout"
  default     = 30
}

variable "publish_version_of_lambda" {
  type        = bool
  description = "Create a version of the lambda"
}

variable "memory_size_in_mb" {
  type    = number
  default = 128
}

variable "dead_letter_queue_arn" {
  description = "Optional dead letter queue arn"
  type        = string
}
