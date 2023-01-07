module "lambda_roles" {
  source = "../../Modules/lambda_roles"

  application_name     = "my-test-app"
  permissions_boundary = null
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

resource "aws_cloudwatch_event_rule" "every_two_minutes" {
  name                = "every-two-minutes"
  description         = "Fires every two minutes"
  schedule_expression = "rate(2 minutes)"
  #  event_bus_name = aws_cloudwatch_event_bus.my_event_bridge.arn //otherwise defaults to the default bus
}

resource "aws_cloudwatch_event_target" "check_foo_every_five_minutes" {
  rule      = aws_cloudwatch_event_rule.every_two_minutes.name
  target_id = "check_foo2"
  arn       = module.lambda_that_gets_triggered.lambda_arn
}

resource "aws_lambda_permission" "event_bridge" {
  statement_id  = "AllowExecutionFromALB"
  action        = "lambda:InvokeFunction"
  function_name = module.lambda_that_gets_triggered.lambda_function_name
  principal     = "events.amazonaws.com"
  //qualifier     = aws_lambda_alias.live.name
  source_arn = aws_cloudwatch_event_rule.every_two_minutes.arn
}


# ****** OUTPUT ******

//lambda info
output "lambda_arn" {
  value = module.lambda_that_gets_triggered.lambda_arn
}

output "lambda_function_name" {
  value = module.lambda_that_gets_triggered.lambda_function_name
}


