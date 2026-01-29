terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"

    }
  }

  # old method "s3+dynamodb"
  # backend "s3" {
  #   bucket          = "<name-of-s3_bucket>"
  #   key             = "<unique-key-for-this-particular-state>" # i.e state of 00-vpc
  #   region          = "us-east-1"
  #   dynamodb_table = "<name-of-dynamodb_table>"
  # }

  # terrafom 1.10+ onwards 
  # backend "s3" {
  #   bucket       = "<s3-bucket-name>"
  #   key          = "<unique-key-for-this-particular-state>" # i.e state of 00-vpc
  #   region       = "us-east-1"
  #   encrypt      = true
  #   use_lockfile = true #s3-native way of locking state files.
  # }

  # -----------
  # Note
  #1.The state file is stored in s3-bucket i.e basically on some physical storage/disk, if someone 
  #  can access that particular disk, they still cannot read state file, if we give "encrypt=true"

  #2.S3-bucket decrypts state file only when terraform requests it or the person with necessary 
  #  permissions can read it on aws console.

  # ----------------------

  backend "s3" {
    bucket       = "expense-dev-bro"
    key          = "expense-dev-bro-vpc"
    region       = "us-east-1"
    encrypt      = true
    use_lockfile = true
  }

}

provider "aws" {
  region = "us-east-1"
}
