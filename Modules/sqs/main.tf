//main queue
resource "aws_sqs_queue" "terraform_queue" {
  name                    = var.main_queue_name
  sqs_managed_sse_enabled = true
  //delay_seconds             = 5
  //receive_wait_time_seconds = 10

  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.terraform_queue_deadletter.arn
    maxReceiveCount     = var.how_many_failures_before_going_to_dead_letter //if it fails x amount of times it will go to the dead letter queue
  })
}

//add the dead letter queue
resource "aws_sqs_queue" "terraform_queue_deadletter" {
  name                    = var.dead_letter_queue_name
  sqs_managed_sse_enabled = true
}

//to not get a circular dependency we add the dead letter queue now
resource "aws_sqs_queue_redrive_allow_policy" "consent_form_requeue" {
  queue_url = aws_sqs_queue.terraform_queue_deadletter.id

  redrive_allow_policy = jsonencode({
    redrivePermission = "byQueue",
    sourceQueueArns   = [aws_sqs_queue.terraform_queue.arn]
  })
}
