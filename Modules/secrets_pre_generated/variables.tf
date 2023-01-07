variable "application_name" {
  description = "Application name which is used for naming resources"
  type        = string
}

variable "secret_name" {
  description = "Secret name"
  type        = string
}

variable "secret_default_value" {
  description = "Dummy value to seed the secret"
  type        = string
  //default = jsonencode({"UserName": "MyUser", "Password": "MyPassword"})
}

variable "secret_recovery_window_in_days" {
  type    = number
  default = 0
}
