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

resource "aws_lb_listener_rule" "lambda_by_request_headers" {
  
  listener_arn = var.aws_alb_listener_arn
  priority     = var.alb_routing_rule_priority

  action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.app.arn
  }

  //couldn't get a great way to conditionally use path or request headers. So start with headers and would need to split the entire module. Couldn't even get it to conditionally render a different resource
  condition {
    http_header {
      http_header_name = var.alb_request_routing_by_request_header_name
      values           = var.alb_request_routing_by_request_header_values
    }
  }
}

resource "aws_alb_target_group" "app" {
  name                               = "${var.lambda_function_name}-tg"
  port                               = var.app_port
  protocol                           = "HTTP"
  vpc_id                             = var.vpc_id
  target_type                        = "lambda"
  lambda_multi_value_headers_enabled = true
}
