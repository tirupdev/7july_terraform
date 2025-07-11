variable "ami_id" {
  description = "The AMI ID to use for the EC2 instance"
  type        = string
  default     = "ami-07891c5a242abf4bc" # ubuntu24
}
variable "instance_type" {
  description = "The type of EC2 instance to create"
  type        = string
  default     = "t3.micro"
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