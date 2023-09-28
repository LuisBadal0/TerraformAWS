terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
  backend "s3" {
    bucket = "dev-applications-backend-state-badalo"
    #key = "07-backend-state-users-dev"
    key = "07-backend-state/users/backend-states"
    region = "eu-west-2"
    dynamodb_table = "dev_application_locks"
    encrypt = true
    
  }

}

# Configure the AWS Provider
provider "aws" {
  region = "eu-west-2"
  # VERSION IS NOT NEEDED HERE
  #Put access to the provider via environment variable instead of hardcoded -> https://registry.terraform.io/providers/hashicorp/aws/latest/docs 
}

#Plan -> Apply


resource "aws_iam_user" "my_iam_user" {
  name = "${terraform.workspace}_my_iam_user_abc"
}

