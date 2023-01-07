resource "aws_alb_target_group" "app" {
  name        = "${var.application_name}-target-group"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip"

  health_check {
    healthy_threshold   = "3"
    interval            = "30"
    protocol            = "HTTP"
    matcher             = "200"
    timeout             = "3"
    path                = var.health_check_path
    unhealthy_threshold = "2"
  }
}

# Redirect all traffic from the ALB to the target group
# resource "aws_alb_listener" "front_end" {
#   load_balancer_arn = var.alb_arn
#   port              = var.app_port
#   protocol          = "HTTP"

#   default_action {
#     target_group_arn = aws_alb_target_group.app.id
#     type             = "forward"
#   }
# }

# resource "aws_lb_listener_rule" "lambda" {
#   listener_arn = var.aws_alb_listener_arn
#   priority     = var.alb_path_priority

#   action {
#     type             = "forward"
#     target_group_arn = aws_alb_target_group.app.arn
#   }

#   condition {
#     path_pattern {
#       values = ["${var.alb_path}"] //this is the url in the alb. So /lambdaName/ after the alb dns name will execute your lambda (make you put the trailing slash)
#     }
#   }
# }