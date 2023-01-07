module "lambda_roles" {
  source = "../../Modules/lambda_roles"

  application_name     = "my-test-app"
  permissions_boundary = null
}

module "my_sqs_queue" {
  source = "../../Modules/sqs"
  //source                                      = "git::https://github.com/dibiancoj/IAC.git//Modules./sqs"
  main_queue_name                               = "my-queue"
  dead_letter_queue_name                        = "my-queue-deadletter"
  cloud_watch_dead_letter_alarm_name            = "my-alarm"
  emails_to_send_on_failure                     = ["test@test.com"]
  how_many_failures_before_going_to_dead_letter = 5
  sns_topic_name_for_dead_letter                = "my-sns"
}


module "lambda_that_gets_triggered" {
  source = "../../Modules/lambda"

  subnet_ids                    = []
  lambda_zip_file_name          = "./artifacts/myfunction.zip"
  function_name                 = "my-lambda"
  handler_namespace_path        = "Src::Src.Function::FunctionHandler"
  runtime                       = "dotnet6"
  lambda_vpc_security_group_ids = [] //["${module.alb.aws_alb_security_group_id}"]
  iam_role_arn_for_lambda       = module.lambda_roles.aws_iam_role_arn
  time_out_in_seconds           = 10
  publish_version_of_lambda     = false
  dead_letter_queue_arn         = null
  env_variables = {
    "testenv" = "bla"
  }
}

resource "aws_lambda_event_source_mapping" "event_source_mapping" {
  event_source_arn = module.my_sqs_queue.main_queue_arn
  enabled          = true
  function_name    = module.lambda_that_gets_triggered.lambda_arn
  batch_size       = 1
}

# ****** OUTPUT ******

//lambda info
output "lambda_arn" {
  value = module.lambda_that_gets_triggered.lambda_arn
}

output "lambda_function_name" {
  value = module.lambda_that_gets_triggered.lambda_function_name
}

output "main_queue_arn" {
  value = module.my_sqs_queue.main_queue_arn
}

output "deadletter_queue_arn" {
  value = module.my_sqs_queue.dead_letter_queue_arn
}
