resource "aws_lb_target_group_attachment" "main" {
  target_group_arn = aws_alb_target_group.app.arn
  target_id        = var.lambda_arn
  depends_on       = [aws_lambda_permission.alb]
}

resource "aws_lambda_permission" "alb" {
  statement_id  = "AllowExecutionFromALB"
  action        = "lambda:InvokeFunction"
  function_name = var.lambda_function_name
  principal     = "elasticloadbalancing.amazonaws.com"
  //qualifier     = aws_lambda_alias.live.name
  source_arn = aws_alb_target_group.app.arn
}

resource "aws_lb_listener_rule" "lambda" {
  listener_arn = var.aws_alb_listener_arn
  priority     = var.alb_path_priority

  action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.app.arn
  }

  condition {
    path_pattern {
      values = ["${var.alb_path}"] //this is the url in the alb. So /lambdaName/ after the alb dns name will execute your lambda (make you put the trailing slash)
    }
  }
}

resource "aws_alb_target_group" "app" {
  name        = "${var.lambda_function_name}-tg"
  port        = var.app_port
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "lambda"
}
