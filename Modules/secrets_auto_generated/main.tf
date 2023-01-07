resource "aws_secretsmanager_secret" "user_secrets" {
  name                    = "user-${var.application_name}-${var.secret_name}" //needs to start with user-
  recovery_window_in_days = var.secret_recovery_window_in_days
}

resource "aws_secretsmanager_secret_version" "secret_version" {
  secret_id     = aws_secretsmanager_secret.user_secrets.id
  secret_string = random_password.generated-password.result
}

resource "random_password" "generated-password" {
  length  = var.secret_length
  special = var.special_characters
}
