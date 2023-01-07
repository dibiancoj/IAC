output "alb_hostname" {
  value = aws_alb.main.dns_name
}

output "raw_alb" {
  value = aws_alb.main
}

output "raw_alb_security_group" {
  value = aws_security_group.alb_security_group
}