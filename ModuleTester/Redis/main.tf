module "my_redis_auth_code" {
  source = "../../Modules/secrets_auto_generated"
  //source                       = "git::https://github.com/dibiancoj/IAC.git//Modules/secrets_auto_generated"
  application_name               = "my_redis_auth_code"
  secret_name                    = "my_redis_auth_code"
  secret_length                  = 16
  special_characters             = false
  secret_recovery_window_in_days = 0
}

module "my_redis" {
  source = "../../Modules/redis"
  //source = "git::https://github.com/dibiancoj/IAC.git//Modules/redis"
  vpc_id                              = "vpc-5dd17e36"
  application_name                    = "my-application"
  redis_cluster_name                  = "my-redis-cluster"
  redis_auth_code_arn                 = module.my_redis_auth_code.secret_arn
  redis_size                          = "cache.t3.small"
  redis_jumpbox_ssh_key_name          = "bla2"
  redis_at_rest_encryption_enabled    = true
  redis_in_transit_encryption_enabled = true
  redis_number_of_node_groups         = 2
  redis_replicas_per_node_group       = 1
  jump_box_image_id                   = "ami-0cc87e5027adcdca8"
}

output "cluster_url" {
  value = module.my_redis.redis_cluster_configuration_url
}

output "jump_box_private_ip" {
  value = module.my_redis.redis_ec2_private_ip
}

output "auth_code_secret_arn" {
  value = module.my_redis_auth_code.secret_arn
}