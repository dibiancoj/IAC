data "aws_subnets" "my_subnets" {
  filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }
}

resource "aws_elasticache_replication_group" "rediscluster" {
  replication_group_id       = var.redis_cluster_name
  description                = var.redis_cluster_name
  node_type                  = var.redis_size
  port                       = 6379
  automatic_failover_enabled = true
  num_node_groups            = var.redis_number_of_node_groups
  replicas_per_node_group    = var.redis_replicas_per_node_group
  at_rest_encryption_enabled = var.redis_at_rest_encryption_enabled
  transit_encryption_enabled = var.redis_in_transit_encryption_enabled
  auth_token                 = data.aws_secretsmanager_secret_version.current.secret_string
  subnet_group_name          = aws_elasticache_subnet_group.Subnet.name
  security_group_ids         = ["${aws_security_group.allow_redis.id}"]
}
