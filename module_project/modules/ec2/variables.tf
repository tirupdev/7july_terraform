variable "instance_type" {
  description = "Type of the EC2 instance"
  type        = string
  default     = "t3.micro"
}

variable "ami_id" {
  description = "AMI ID for the EC2 instance"
  type        = string
  default     = "ami-07891c5a242abf4bc" # ubuntu24
}

variable "user_data" {
  description = "User data script to run on instance launch"
  type        = string
  default     = <<-EOF
                #!/bin/bash
                apt-get update -y
                apt-get install nginx -y
                systemctl start nginx
                systemctl enable nginx
                EOF
}

variable subnet_id {
  description = "The ID of the subnet in which to launch the EC2 instance"
  type        = string
}

variable "aws_sns_topic_arn" {
  description = "ARN of the SNS topic to publish instance state changes"
  type        = string
  
}

variable "security_group_id" {
  type = string
  description = "Security Group ID to attach to EC2 instance"
}
