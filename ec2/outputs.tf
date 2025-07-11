output "instance_id" {
  description = "The ID of the created EC2 instance"
  value       = aws_instance.web_nginx.id
}

output "instance_public_ip" {
  description = "The public IP address of the created EC2 instance"
  value       = aws_instance.web_nginx.public_ip
}

output "instance_private_ip" {
  description = "The private IP address of the created EC2 instance"
  value       = aws_instance.web_nginx.private_ip
}