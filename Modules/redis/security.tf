resource "aws_security_group" "allow_redis" {
  name        = "${var.application_name}-securitygroup-allow-redis"
  description = "Allow Redis elastic cache"
  vpc_id      = var.vpc_id

  ingress {
    description      = "Allow Redis elastic cache"
    from_port        = 6379
    to_port          = 6379
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

resource "aws_security_group" "allow_ssh" {
  name        = "${var.application_name}-securitygroup-allow-ssh"
  description = "Allow ssh into ec2"
  vpc_id      = var.vpc_id

  ingress {
    description = "Allow ssh into ec2"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}
