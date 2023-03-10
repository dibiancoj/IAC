resource "aws_lambda_function" "test_lambda" {
  # If the file is not in the current working directory you will need to include a
  # path.module in the filename.
  filename      = var.lambda_s3_bucket == null ? var.lambda_zip_file_name : null //"./artifacts/Jobs.zip"
  function_name = var.function_name                                              //local.name
  role          = var.iam_role_arn_for_lambda                                    //aws_iam_role.iam_for_lambda_tf.arn
  handler       = var.handler_namespace_path                                     //"JasonLambda2::JasonLambda2.Function::FunctionHandler"

  timeout     = var.time_out_in_seconds
  memory_size = var.memory_size_in_mb

  publish = var.publish_version_of_lambda

  # The filebase64sha256() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the base64sha256() function and the file() function:
  # source_code_hash = "${base64sha256(file("lambda_function_payload.zip"))}"
  source_code_hash = filebase64sha256(var.lambda_zip_file_name) //filebase64sha256("artifacts/Jobs.zip")

  //if not local file pull from s3
  s3_bucket = var.lambda_s3_bucket
  s3_key    = var.lambda_s3_key

  runtime = var.runtime //"dotnet6"

  dynamic "dead_letter_config" {
    //if the variable is not null push to array of 1 item. Otherwise its a blank array
    for_each = var.dead_letter_queue_arn != null ? toset([1]) : toset([])

    content {
      target_arn = var.dead_letter_queue_arn
    }
  }

  vpc_config {
    subnet_ids         = var.subnet_ids
    security_group_ids = var.lambda_vpc_security_group_ids //[aws_security_group.lb.id]
  }

  environment {
    # variables = {
    #   foo = "bar"
    # }
    variables = var.env_variables
  }
}
