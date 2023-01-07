data "aws_secretsmanager_secret" "secrets_root_pw" {
  arn = var.db_admin_user_pw_arn
}

data "aws_secretsmanager_secret_version" "current" {
  secret_id = data.aws_secretsmanager_secret.secrets_root_pw.id
}
