provider "aws" {
  region = "ap-south-2" # Hyderabad region

}
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

resource "aws_instance" "imported_ec2" {
    
}
