output "ecs_service" {
  value = aws_ecs_service.main
}

output "raw_alb_target_group" {
  value = aws_alb_target_group.app
}