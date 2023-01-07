# logs.tf

# Set up CloudWatch group and log stream and retain logs for 30 days
resource "aws_cloudwatch_log_group" "app_log_group" {
  name              = "/ecs/${var.application_name}-app"
  retention_in_days = 30

  tags = {
    Name = "${var.application_name}-log-group"
  }
}

resource "aws_cloudwatch_log_stream" "app_log_stream" {
  name           = "${var.application_name}-log-stream"
  log_group_name = aws_cloudwatch_log_group.app_log_group.name
}
