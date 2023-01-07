resource "aws_instance" "docdb_jumpbox" {
  tags = {
    Name = "${var.application_name}-docdb-jump-box"
  }
  ami                    = var.jumpbox_image_id
  instance_type          = "t3.micro"
  key_name               = var.jumpbox_ssh_key_name
  vpc_security_group_ids = ["${aws_security_group.allow_ssh.id}"]
  subnet_id              = data.aws_subnets.my_subnets.ids[0]
}
