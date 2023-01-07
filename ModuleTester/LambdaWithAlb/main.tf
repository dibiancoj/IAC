locals {
  vpc_id = "vpc-5dd17e36"
}

module "alb" {
  source = "../../Modules/lambda_alb"

  application_name     = "myalb"
  vpc_id               = local.vpc_id
  app_port             = 80
  internal_access_only = false
}

module "lambda_roles" {
  source = "../../Modules/lambda_roles"

  application_name     = "my-test-app"
  permissions_boundary = null
}

module "lambda_that_gets_triggered_one" {
  source = "../../Modules/lambda"

  subnet_ids                    = []
  lambda_zip_file_name          = "./artifacts/myfunction.zip"
  function_name                 = "my-lambda-one"
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

module "lambda_that_gets_triggered_two" {
  source = "../../Modules/lambda"

  subnet_ids                    = []
  lambda_zip_file_name          = "./artifacts/myfunction.zip"
  function_name                 = "my-lambda-two"
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

module "alb_lambda_function_one" {
  source = "../../Modules/lambda_alb_function_instance"

  vpc_id               = local.vpc_id
  lambda_arn           = module.lambda_that_gets_triggered_one.lambda_arn
  lambda_function_name = module.lambda_that_gets_triggered_one.lambda_function_name
  aws_alb_listener_arn = module.alb.alb_listender_arn
  app_port             = 80

  alb_request_routing_by_request_header_name   = "my-header"
  alb_request_routing_by_request_header_values = ["my-header-value-1"]
  alb_routing_rule_priority                    = 100
}

module "alb_lambda_function_two" {
  source = "../../Modules/lambda_alb_function_instance"

  vpc_id               = local.vpc_id
  lambda_arn           = module.lambda_that_gets_triggered_two.lambda_arn
  lambda_function_name = module.lambda_that_gets_triggered_two.lambda_function_name
  aws_alb_listener_arn = module.alb.alb_listender_arn
  app_port             = 80

  //this will be header based. So request header determines if it should send to this lambda
  alb_request_routing_by_request_header_name   = "my-header"
  alb_request_routing_by_request_header_values = ["my-header-value-2"]
  alb_routing_rule_priority                    = 200
}

# ****** OUTPUT ******

output "alb_url" {
  value = module.alb.aws_alb_dns
}

output "lambda_one_arn" {
  value = module.lambda_that_gets_triggered_one.lambda_arn
}

output "lambda_two_arn" {
  value = module.lambda_that_gets_triggered_two.lambda_arn
}
