terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
  
}

# Configure the AWS Provider
provider "aws" {
  region = "eu-west-2"
  # VERSION IS NOT NEEDED HERE
  #Put access to the provider via environment variable instead of hardcoded -> https://registry.terraform.io/providers/hashicorp/aws/latest/docs
}

#Plan -> Apply

##Create bucket/Storage
resource "aws_s3_bucket" "my_s3_bucket" {
    bucket = "my-s3-bucket-badalo-123"
}

