#================================================
# Authentication to AWS
terraform {
  backend "s3" {
    bucket               = "anabode-terraform-state-sharedservices" ## this can stay inside the sharedservices ## DO NOT TOUCH this configuration except the key, change that to env_name
    key                  = "web-dashboard.json"
    region               = "eu-west-1"
    workspace_key_prefix = "tf-state/sharedservices"
    dynamodb_table       = "anabode-terraform-eu-west-1"
  }
}


terraform {
  required_version = ">= 1"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}


provider "aws" {
  region = var.region
  assume_role {
    role_arn = var.workspace_iam_role
  }
}

provider "aws" {
  region = var.region
  alias  = "dns"
  assume_role {
    role_arn = var.dns_iam_role
  }
}

provider "aws" {
  alias  = "use1"
  region = "us-east-1"
  assume_role {
    role_arn = var.workspace_iam_role
  }
}
