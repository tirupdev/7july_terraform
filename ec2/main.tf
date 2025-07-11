terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}
provider "aws" {
  region = "ap-south-2"
}   

resource "aws_instance" "web_nginx" {
    ami           = var.ami_id
    instance_type = var.instance_type
    user_data = var.user_data
    vpc_security_group_ids = [aws_security_group.Hyderabad2_sg.id]
    subnet_id = aws_subnet.Hyderabad2_subnet.id
    key_name = aws_key_pair.july8_key.key_name
    associate_public_ip_address = true


  tags = {
    Name        = "web-nginx"
    environment = "dev"
    }
}

resource "aws_security_group" "Hyderabad2_sg" {
  name        = "Hyderabad2_sg"
  description = "Security group for Hyderabad2 VPC"
  vpc_id      = aws_vpc.Hyderabad2.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}


resource "aws_key_pair" "july8_key" {
  key_name   = "july8"
  public_key = file("/home/tirupubuntu24/.ssh/july8.pub")
  tags = {
      Name        = "july8_key"
      environment = "dev"
  }
}
