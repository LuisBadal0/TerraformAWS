terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }

}

variable "aws_key_pair" {
  default = "~/aws/aws_keys/default-ec2.pem"
}

# Configure the AWS Provider
provider "aws" {
  region = "eu-west-2"
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
  name   = "http_server_sg"
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
  ami                    = "ami-0b25f6ba2f4419235"
  key_name               = "default-ec2"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.http_server_sg.id]
  subnet_id              = "subnet-0ab30df0d626c6175"

  connection {
    type        = "ssh"
    host        = self.public_ip
    user        = "ec2-user"
    private_key = file(var.aws_key_pair)
  }

  provisioner "remote-exec" {
    inline = [
      "sudo yum install httpd -y",                                                             //install httpd
      "sudo service httpd start",                                                              //start server
      "echo Welcome Badalo - VS is at ${self.public_dns} | sudo tee /var/www/html/index.html", //copy a file
    ]
  }
}