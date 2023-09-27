terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }

}

variable "names" {
  default = ["Ana", "Luis", "Jose"]
}
# Configure the AWS Provider
provider "aws" {
  region = "eu-west-2"
  # VERSION IS NOT NEEDED HERE
  #Put access to the provider via environment variable instead of hardcoded -> https://registry.terraform.io/providers/hashicorp/aws/latest/docs 
}

##Create multiple users
resource "aws_iam_user" "my_iam_users" {
  count = length(var.names)
  name  = var.names[count.index]
}

