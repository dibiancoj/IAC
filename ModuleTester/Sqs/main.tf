module "my_sqs_queue" {
  source = "../../Modules/sqs"
  //source                                      = "git::https://github.com/dibiancoj/IAC.git//Modules./sqs"
  main_queue_name                               = "my-queue"
  dead_letter_queue_name                        = "my-queue-deadletter"
  cloud_watch_dead_letter_alarm_name            = "my-alarm"
  emails_to_send_on_failure                     = ["myemail@gmail.com"]
  how_many_failures_before_going_to_dead_letter = 5
  sns_topic_name_for_dead_letter                = "my-sns"
}

output "main_queue_arn" {
  value = module.my_sqs_queue.main_queue_arn
}

output "deadletter_queue_arn" {
  value = module.my_sqs_queue.dead_letter_queue_arn
}
