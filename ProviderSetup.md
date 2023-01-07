Cli to create the resources to use a back end provider

```aws s3api create-bucket --bucket testbucket --region us-east-1```

```aws s3api put-public-access-block --bucket testbucket --public-access-block-configuration "BlockPublicAcls=true,IgnorePublicAcls=true,BlockPublicPolicy=true,RestrictPublicBuckets=true"```

Provider File
-----------
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
