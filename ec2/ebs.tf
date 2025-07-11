resource "aws_ebs_volume" "add_gb2" {
  availability_zone = aws_instance.web_nginx.availability_zone
  size              = 20
  type              = "gp3"
  tags = {
    Name = "extra-ebs-volume"
  }
}

resource "aws_volume_attachment" "attach_ebs" {
  device_name = "/dev/sdf"
  volume_id   = aws_ebs_volume.add_gb2.id
  instance_id = aws_instance.web_nginx.id

}