resource "aws_secretsmanager_secret" "user_secrets" {
  name                    = "user-${var.application_name}-${var.secret_name}" //needs to start with user
  recovery_window_in_days = var.secret_recovery_window_in_days

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_secretsmanager_secret_version" "secret_version" {
  secret_id     = aws_secretsmanager_secret.user_secrets.id
  secret_string = var.secret_default_value

  #we don't want this to change after you corrected the values
  lifecycle {
    create_before_destroy = true
    ignore_changes = [
      secret_string
    ]
  }
}
