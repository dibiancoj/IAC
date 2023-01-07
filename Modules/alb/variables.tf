variable "vpc_id" {
  description = "Vpc Id"
  type        = string
}

variable "alb_name" {
  description = "Load balancer name"
  type        = string
}

variable "alb_is_internal_access_only" {
  description = "Internal vs external alb access. Internal access only? "
  type        = bool
}

variable "app_port" {
  description = "Port to listena nd push traffic on"
  default     = 80
  type        = number
}
