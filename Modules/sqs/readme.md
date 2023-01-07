Version 1.0
 - Initial Release

***
 
 Please see [here](https://github.com/dibiancoj/IAC/tree/main/ModuleTester/Sqs) for a working example.

```
module "my_sqs_queue" {
  source                                        = "../IAC/sqs"
  //or if you aren't making changes you can run it from the git repo which has the latest stable version. To update cd to .terraform/modules/sqs and run a git pull.
  //source                                      = "git::https://github.com/dibiancoj/IAC.git//Modules/sqs"
  main_queue_name                               = "my-queue"
  dead_letter_queue_name                        = "my-queue-deadletter"
  cloud_watch_dead_letter_alarm_name            = "my-alarm"
  emails_to_send_on_failure                     = ["my-email@gmail.com"]
  how_many_failures_before_going_to_dead_letter = 5
  sns_topic_name_for_dead_letter                = "my-sns"
}

output "my_sqs_queue_main_queue" {
  value = module.my_sqs_queue.main_queue_arn
}

output "my_sqs_queue_main_queue_deadletter" {
  value = module.my_sqs_queue.dead_letter_queue_arn
}
```

#### Run:
- ```terraform init```
- ```terraform plan```
- ```terraform apply```
