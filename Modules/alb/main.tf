data "aws_subnets" "my_subnets" {
  filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }
}

resource "aws_alb" "main" {
  name            = var.alb_name
  internal        = var.alb_is_internal_access_only
  subnets         = data.aws_subnets.my_subnets.ids //aws_subnet.public.*.id
  security_groups = [aws_security_group.lb.id]
}
