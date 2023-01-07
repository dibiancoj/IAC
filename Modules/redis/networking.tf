resource "aws_elasticache_subnet_group" "Subnet" {
  name       = "${var.application_name}-subnet"
  subnet_ids = data.aws_subnets.my_subnets.ids
}
