variable "environment" {
  default = "default"
  
}

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

resource "aws_iam_user" "my_iam_user" {
    name = "${local.iam_user_extension}_${var.environment}"
}
//local variables
locals {
  iam_user_extension = "my_iam_user_abc"
}