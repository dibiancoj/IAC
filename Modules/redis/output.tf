output "redis_cluster_configuration_url" {
  value = aws_elasticache_replication_group.rediscluster.configuration_endpoint_address
}

output "redis_ec2_private_ip" {
  value = aws_instance.redis_jumpbox.private_ip
}
