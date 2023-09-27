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

##Resources
##Create bucket/Storage
resource "aws_s3_bucket" "my_s3_bucket" {
    bucket = "my-s3-bucket-badalo-123"
}

resource "aws_s3_bucket_versioning" "versioning_example" {
  bucket = aws_s3_bucket.my_s3_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_iam_user" "my_iam_user" {
    name = "my_iam_user_abc_updated2"
}

