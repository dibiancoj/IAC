output "main_queue_arn" {
  value = aws_sqs_queue.terraform_queue.arn
}

output "dead_letter_queue_arn" {
  value = aws_sqs_queue.terraform_queue.arn
}

output "sns_topic_dead_letter_arc" {
  value = aws_sns_topic.user_updates.arn
}
