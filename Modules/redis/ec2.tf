resource "aws_instance" "redis_jumpbox" {
  tags = {
    Name = "${var.application_name}-redis-jump-box"
  }
  ami                    = var.jump_box_image_id
  instance_type          = "t3.micro"
  key_name               = var.redis_jumpbox_ssh_key_name
  vpc_security_group_ids = ["${aws_security_group.allow_ssh.id}"]
  subnet_id              = data.aws_subnets.my_subnets.ids[0]
}
