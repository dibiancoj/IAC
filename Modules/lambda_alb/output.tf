output "alb_listender_arn" {
  value = aws_alb_listener.front_end.arn
}

# output "aws_alb_target_group_arn" {
#   value = aws_alb_target_group.app.arn
# }

output "aws_alb_dns" {
  value = aws_alb.main.dns_name
}

output "aws_alb_security_group_id" {
  value = aws_security_group.lb.id
}
