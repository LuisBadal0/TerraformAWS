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

//S3 bucket
resource "aws_s3_bucket" "enterprise_backend_state" {
    bucket = "dev-applications-backend-state-badalo"

    lifecycle {
      prevent_destroy = true
    }
}

resource "aws_s3_bucket_versioning" "versioning_example" {
      bucket = aws_s3_bucket.enterprise_backend_state.id
      versioning_configuration {
        status = "Enabled"
      }
    }

resource "aws_s3_bucket_server_side_encryption_configuration" "example" {
      bucket = aws_s3_bucket.enterprise_backend_state.bucket
     
      rule {
        apply_server_side_encryption_by_default {
          sse_algorithm     = "AES256"
        }
      }    
}


//Locking - Dynamo DB

resource "aws_dynamodb_table" "entreprise_backend_lock" {
    name = "dev_application_locks"
    billing_mode = "PAY_PER_REQUEST"

    hash_key = "LockID"
    
    attribute {
      name = "LockID"
      type = "S"
    }
  
}