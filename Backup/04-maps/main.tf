terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }

}

variable "users" {
  default = {
    Rafael : { country : "Netherlands", departement : "ABC" },
    Luis : { country : "Portugal", departement : "ABC" },
    Jose : { country : "Spain", departement : "AZB" }
  }
}
# Configure the AWS Provider
provider "aws" {
  region = "eu-west-2"
  # VERSION IS NOT NEEDED HERE
  #Put access to the provider via environment variable instead of hardcoded -> https://registry.terraform.io/providers/hashicorp/aws/latest/docs 
}

##Create multiple users
resource "aws_iam_user" "my_iam_users" {
  for_each = var.users
  name     = each.key
  tags = {
    #country:each.value
    country : each.value.country
    departement : each.value.departement
  }
}

