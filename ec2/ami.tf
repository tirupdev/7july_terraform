resource "aws_ami_from_instance" "nginx-image" {
  name               = "web-nginx-ami"
  source_instance_id = aws_instance.web_nginx.id
  tags               = {
    Name        = "web-nginx-ami"
    Generation = "1"
  }
}

output "ami_id" {
  value = aws_ami_from_instance.nginx-image.id
}