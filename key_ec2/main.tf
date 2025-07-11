provider "aws" {
  region = "ap-south-2"
}

# Default VPC for networking
data "aws_vpc" "default" {
  default = true
}

data "aws_subnet" "default" {
  filter {
    name   = "default-for-az"
    values = ["true"]
  }
  filter {
    name   = "availability-zone"
    values = ["ap-south-2a"]
  }
}

# Create new security group for SSH
resource "aws_security_group" "allow_ssh" {
  name        = "tf-allow-ssh"
  description = "Allow SSH access"
  vpc_id      = data.aws_vpc.default.id

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

# SSH Key Pair (uses your local public key)
resource "aws_key_pair" "tf_key" {
  key_name   = "tf-ssh-key"
  public_key = file("~/.ssh/tirup.pub")
}

# EC2 Instance
resource "aws_instance" "tf_ec2" {
  ami                         = "ami-07891c5a242abf4bc" # Ubuntu 24.04 in ap-south-2
  instance_type               = "t3.micro"
  subnet_id                   = data.aws_subnet.default.id
  associate_public_ip_address = true
  key_name                    = aws_key_pair.tf_key.key_name
  vpc_security_group_ids      = [aws_security_group.allow_ssh.id]

  tags = {
    Name = "terraform-ec2"
  }
}

# Outputs
output "public_ip" {
  value = aws_instance.tf_ec2.public_ip
}

output "ssh_command" {
  value = "ssh -i ~/.ssh/tirup ubuntu@${aws_instance.tf_ec2.public_ip}"
}
