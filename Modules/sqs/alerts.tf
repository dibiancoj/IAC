//add notification for failures
resource "aws_sns_topic" "user_updates" {
  name = var.sns_topic_name_for_dead_letter
}

resource "aws_sns_topic_subscription" "sends_email_on_failure" {
  for_each  = var.emails_to_send_on_failure
  topic_arn = aws_sns_topic.user_updates.arn
  protocol  = "email"
  endpoint  = each.value
}

resource "aws_cloudwatch_metric_alarm" "sqs_dead_letter_was_in_queue" {
  alarm_name  = var.cloud_watch_dead_letter_alarm_name
  namespace   = "AWS/SQS"
  metric_name = "ApproximateNumberOfMessagesVisible"
  dimensions = {
    QueueName = var.dead_letter_queue_name
  }
  statistic           = "Sum"
  period              = "60"
  evaluation_periods  = "1"
  threshold           = "0"
  comparison_operator = "GreaterThanThreshold"
  treat_missing_data  = "notBreaching"
  alarm_description   = "There is a queue message in your dead letter queue."
  alarm_actions       = [aws_sns_topic.user_updates.arn]
}
