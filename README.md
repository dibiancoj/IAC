### IAC With Terraform Modules

See [Modules](https://github.com/dibiancoj/IAC/tree/main/Modules) to build with. Each module will give specific instructions with examples.

#### Run:
- ```terraform fmt -recursive```
- ```terraform init```
- ```terraform plan```
- ```terraform apply```

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

### Provider Setup

Cli to create the resources to use a back end provider

```aws s3api create-bucket --bucket testbucket --region us-east-1```

```aws s3api put-public-access-block --bucket testbucket --public-access-block-configuration "BlockPublicAcls=true,IgnorePublicAcls=true,BlockPublicPolicy=true,RestrictPublicBuckets=true"```

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
