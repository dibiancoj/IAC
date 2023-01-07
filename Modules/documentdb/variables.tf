variable "vpc_id" {
  description = "Vpc Id"
  type        = string
}

variable "application_name" {
  description = "Application name which is used for naming resources"
  type        = string
}

variable "cluster_name" {
  description = "Cluster name"
  type        = string
}

variable "db_instance_name" {
  description = "Database name"
  type        = string
}

variable "db_encryption_at_rest" {
  default = true
  type    = bool
}

variable "db_instance_count" {
  type        = number
  description = "Number of instance counts. (1 just a primary. 2 primary and replica)"
  default     = 2
}

variable "db_admin_user_name" {
  description = "User name for the database root account"
  type        = string
}

variable "db_admin_user_pw_arn" {
  description = "Arn for the root password secret in the database"
  type        = string
}

variable "db_instance_type" {
  description = "Specs on the database instance type"
  type        = string

  validation {
    condition     = contains(["db.t3.medium", "db.r6g.large", "db.r6g.xlarge", "db.r6g.2xlarge", "db.r6g.4xlarge", "db.r6g.8xlarge"], var.db_instance_type)
    error_message = "Invalid instance size."
  }
}

variable "backup_retention_period" {
  description = "backup_retention_period"
  default     = 5
  type        = number
}

variable "deletion_protection" {
  description = "Don't allow for this database to be deleted without additional steps"
  default     = false
  type        = bool
}

variable "jumpbox_ssh_key_name" {
  description = "ssh key file name"
  type        = string
}

variable "jumpbox_image_id" {
  default = "ami-090fa75af13c156b4"
  type    = string
}
