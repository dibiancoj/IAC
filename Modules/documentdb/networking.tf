resource "aws_docdb_subnet_group" "default" {
  name       = var.application_name
  subnet_ids = data.aws_subnets.my_subnets.ids

  tags = {
    Name = "My docdb subnet group"
  }
}
