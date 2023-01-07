resource "aws_iam_role" "iam_for_lambda_tf" {
  name                 = "userServiceRoleLambdaTaskExecutionRole-${var.application_name}"
  permissions_boundary = var.permissions_boundary
  assume_role_policy   = <<EOF
    {
    "Version": "2012-10-17",
    "Statement": [
        {
        "Action": "sts:AssumeRole",
        "Principal": {
            "Service": "lambda.amazonaws.com"
        },
        "Effect": "Allow",
        "Sid": ""
        }
    ]
    }
    EOF
}

resource "aws_iam_role_policy" "secret_manager_policy" {
  name = "secret_manager_access_permissions-${var.application_name}"
  role = aws_iam_role.iam_for_lambda_tf.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "secretsmanager:GetRandomPassword", //lambda to pull secrets
          "secretsmanager:GetResourcePolicy",
          "secretsmanager:GetSecretValue",
          "secretsmanager:DescribeSecret",
          "secretsmanager:ListSecretVersionIds",
          "secretsmanager:ListSecrets",
          "docdb-elastic:*",    //allow lambda to talk to doc db
          "sqs:ReceiveMessage", //sqs trigger lambda
          "sqs:DeleteMessage",
          "sqs:GetQueueAttributes",
          "events:*" //event bridge with cron
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "AWSLambdaVPCAccessExecutionRole" {
  role       = aws_iam_role.iam_for_lambda_tf.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole"
}
