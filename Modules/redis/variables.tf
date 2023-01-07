variable "vpc_id" {
  description = "Vpc Id"
  type        = string
}

variable "application_name" {
  description = "Application name which is used for naming resources"
  type        = string
}

variable "redis_cluster_name" {
  description = "Redis Cluster Name"
  type        = string
}

variable "redis_auth_code_arn" {
  description = "Redis auth code arn"
  type        = string
}

variable "redis_size" {
  description = "Redis Cluster Name"
  default     = "cache.t3.micro"

  validation {
    condition     = contains(["cache.t3.micro", "cache.t3.small", "cache.t3.medium", "cache.r5.large", "cache.r5.xlarge", "cache.r5.2xlarge", "cache.r5.4xlarge", "cache.r5.12xlarge", "cache.r5.24xlarge", "cache.m5.large", "cache.m5.xlarge", "cache.m5.2xlarge", "cache.m5.4xlarge", "cache.m5.12xlarge", "cache.m5.24xlarge"], var.redis_size)
    error_message = "Invalid redis size."
  }
}

variable "redis_jumpbox_ssh_key_name" {
  description = "ssh key file name"
  type        = string
}

variable "redis_at_rest_encryption_enabled" {
  default = true
  type    = bool
}

variable "redis_in_transit_encryption_enabled" {
  default = true
  type    = bool
}

variable "redis_number_of_node_groups" {
  default = 2
  type    = number
}

variable "redis_replicas_per_node_group" {
  default = 1
  type    = number
}

variable "jump_box_image_id" {
  default = "ami-090fa75af13c156b4"
  type    = string
}
