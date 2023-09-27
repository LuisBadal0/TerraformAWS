variable "region" {
  default = "eu-west-2"

}
variable "instance_type" {
  default = "t2.micro"

}

variable "aws_key_pair" {
  default = "~/aws/aws_keys/default-ec2.pem"
}