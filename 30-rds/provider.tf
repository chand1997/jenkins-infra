terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"

    }
  }
  backend "s3" {
    bucket       = "expense-dev-bro"
    key          = "expense-dev-bro-rds"
    region       = "us-east-1"
    encrypt      = true
    use_lockfile = true
  }
}

provider "aws" {
  region = "us-east-1"
}