variable "application_name" {
  description = "Application name which is used for naming resources"
  type        = string
}

variable "secret_name" {
  description = "Secret name"
  type        = string
}

variable "secret_length" {
  description = "Length of the secret"
  type        = number
}

variable "special_characters" {
  description = "Use special characters"
  default     = false
  type        = bool
}

variable "secret_recovery_window_in_days" {
  type    = number
  default = 0
}
