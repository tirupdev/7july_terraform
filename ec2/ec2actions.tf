resource "aws_ec2_instance_state" "stop_instance" {
  instance_id = aws_instance.web_nginx.id
  state       = "stopped"
  
}
resource "aws_ec2_instance_state" "start_instance" {
  instance_id = aws_instance.web_nginx.id
  state       = "running"
}