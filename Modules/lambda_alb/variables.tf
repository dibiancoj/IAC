variable "application_name" {
  type = string
}

variable "subnets" {
  description = "Subnets"
}

variable "app_port" {
  description = "Application port"
}

variable "vpc_id" {
  description = "Vpc Id"
}

variable "internal_access_only" {
  type        = bool
  description = "Only internal access or create a public dns for it and make it available through www"
}
