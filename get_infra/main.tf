resource "aws_instance" "example" {
  ami           = "ami-042b4708b1d05f512" # Amazon Linux 2 AMI (us-east-1)
  instance_type = "t3.micro"
  region="eu-north-1"
  tags = {
    Name = "myvm"
  }
}
provider "aws" {
  region = "eu-north-1"
  default     = "eu-north-1"
}