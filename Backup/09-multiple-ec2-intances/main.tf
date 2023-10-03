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
  region = var.region
  # VERSION IS NOT NEEDED HERE
  #Put access to the provider via environment variable instead of hardcoded -> https://registry.terraform.io/providers/hashicorp/aws/latest/docs 
}

resource "aws_default_vpc" "default" {
  tags = {
    Name = "Default VPC"
  }
}

//http Server -> 80 TCP, 22 TCP, CIDR ["0.0.0.0/0"]

//Security Group

resource "aws_security_group" "http_server_sg" {
  name = "http_server_sg"
  //vpc_id = "vpc-0cc097fd81330d115"
  vpc_id = aws_default_vpc.default.id
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    name = "http_server_sg"
  }

}

resource "aws_instance" "http_server" {
  ami                    = data.aws_ami.aws_linux_2023_latest.id
  count                  = 3
  key_name               = "default-ec2"
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.http_server_sg.id]
  subnet_id              = data.aws_subnets.default_subnets.ids[0]
}
