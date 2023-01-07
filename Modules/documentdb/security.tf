resource "aws_security_group" "allow_doc_db" {
  name        = "${var.application_name}-securitygroup-allow-docdb"
  description = "Allow doc db"
  vpc_id      = var.vpc_id

  ingress {
    description      = "Allow doc db"
    from_port        = 27017
    to_port          = 27017
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
  name        = "${var.application_name}-securitygroup-allow-ssh_for_docdb"
  description = "Allow ssh into ec2 for doc db"
  vpc_id      = var.vpc_id

  ingress {
    description = "Allow ssh into ec2 for doc db"
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
