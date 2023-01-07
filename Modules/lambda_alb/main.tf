resource "aws_alb" "main" {
  name            = "${var.application_name}-load-balancer"
  internal        = var.internal_access_only
  subnets         = var.subnets //aws_subnet.public.*.id
  security_groups = [aws_security_group.lb.id]
}

# resource "aws_alb_target_group" "app" {
#   name        = "${var.application_name}-target-group"
#   port        = var.app_port
#   protocol    = "HTTP"
#   vpc_id      = var.vpc_id
#   target_type = "lambda"
# }

resource "aws_alb_listener" "front_end" {
  load_balancer_arn = aws_alb.main.id
  port              = var.app_port
  protocol          = "HTTP"

  default_action {
    #   target_group_arn = aws_alb_target_group.app.id
    #   type             = "forward"
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      status_code  = "404"
    }
  }
}
