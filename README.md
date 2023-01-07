### IAC With Terraform Modules

See [Modules](https://github.com/dibiancoj/IAC/tree/main/Modules) to build with. Each module will give specific instructions with examples.

#### Run:
- ```terraform fmt -recursive```
- ```terraform init```
- ```terraform plan```
- ```terraform apply```
- ```terraform apply -var-file="dev.tfvars" -var path_to_lambda_zips_base_directory="./MyFolder"```

##### Subnet DataSource
```
data "aws_subnets" "my_subnets" {
  filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }
}

Then Use: data.aws_subnets.my_subnets.ids
Or data.aws_subnets.my_subnets.ids[0]
```
-----------

### Provider Setup (provider.tf)

Cli to create the resources to use a back end provider

```aws s3api create-bucket --bucket testbucket --region us-east-1```

```aws s3api put-public-access-block --bucket testbucket --public-access-block-configuration "BlockPublicAcls=true,IgnorePublicAcls=true,BlockPublicPolicy=true,RestrictPublicBuckets=true"```

```aws dynamodb create-table --table-name my-terraform-table --attribute-definitions AttributeName=LockID,AttributeType=S --table-class STANDARD --key-schema AttributeName=LockID,KeyType=HASH --region us-east-1 --provisioned-throughput ReadCapacityUnits=1,WriteCapacityUnits=1```

```
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
  backend "s3" {
    bucket         = "my-microservice-cluster-dev"
    key            = "state/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "terraform-state-cluster"
    profile        = "saml"
  }
}

provider "aws" {
  profile = "saml"
  region  = "us-east-1"
}
```

-----------

### Https Listner
1. Upload Cert To Certificate Manager. This value would be var.app_certificate_arn

```
resource "aws_alb_listener" "front_end_HTTPS" {
  load_balancer_arn = aws_alb.main.id
  port              = var.app_secure_port
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-FS-1-2-Res-2020-10"
  certificate_arn   = var.app_certificate_arn

  default_action {
    target_group_arn = aws_alb_target_group.app.id
    type             = "forward"
  }
}

resource "aws_security_group" "lb" {
  name        = "${var.application_name}-load-balancer-security-group"
  description = "controls access to the ALB"
  vpc_id      = var.vpc_id

  ingress {
    protocol    = "tcp"
    from_port   = var.app_port
    to_port     = var.app_port
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    protocol    = "tcp"
    from_port   = 443
    to_port     = 443
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}
```

-----------

### Header based routing for listner rules

```
resource "aws_lb_listener_rule" "lambda" {
  listener_arn = var.aws_alb_listener_arn
  priority     = var.alb_path_priority

  action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.app.arn
  }

  condition {
    http_header {
      values           = ['my-header-value'] 
      http_header_name = "my-header-name
    }
  }
}
```

-----------

### Dynamic sub configuration

```
  dynamic "dead_letter_config" {
    //if the variable is not null push to array of 1 item. Otherwise its a blank array
    for_each = var.dead_letter_queue_arn != null ? toset([1]) : toset([])

    content {
      target_arn = var.dead_letter_queue_arn
    }
  }
```
