data "aws_subnets" "my_subnets" {
  filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }
}

resource "aws_docdb_cluster" "docdb" {
  cluster_identifier = var.cluster_name
  engine             = "docdb"
  //master_username         = "${jsondecode(data.aws_secretsmanager_secret_version.current.secret_string)["username"]}"
  //master_password         = "${jsondecode(data.aws_secretsmanager_secret_version.current.secret_string)["password"]}"
  master_username         = var.db_admin_user_name
  master_password         = data.aws_secretsmanager_secret_version.current.secret_string
  backup_retention_period = var.backup_retention_period
  skip_final_snapshot     = true
  vpc_security_group_ids  = ["${aws_security_group.allow_doc_db.id}"]
  db_subnet_group_name    = aws_docdb_subnet_group.default.id
  storage_encrypted       = var.db_encryption_at_rest
}

resource "aws_docdb_cluster_instance" "cluster_instances" {
  count              = var.db_instance_count
  identifier         = "${var.cluster_name}-instance-${count.index}"
  cluster_identifier = aws_docdb_cluster.docdb.id
  instance_class     = var.db_instance_type
}
