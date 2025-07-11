provider "aws" {
  region = "ap-south-2"
}

module "vpc" {
  source     = "./modules/vpc"
  cidr_block = "10.10.10.0/24"
}

resource "aws_security_group" "my_sg" {
  name        = "allow-ssh"
  description = "Allow SSH"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
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

module "sns" {
  source = "./modules/sns"
}
module "ec2" {
  source            = "./modules/ec2"
  subnet_id         = module.vpc.public_subnet_id
  aws_sns_topic_arn = module.sns.aws_sns_topic_arn
  security_group_id = aws_security_group.my_sg.id   # ✅ FIXED
}
