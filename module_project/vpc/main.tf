resource "aws_vpc" "Hyd2" {
  cidr_block = "${var.cidr_block}"


  tags = {
    Name = "Hyd2"
  }
}

resource "aws_subnet" "Hyd2_subnet" {
  vpc_id            = aws_vpc.Hyd2.id
  cidr_block        = "10.100.10.0/26"
  availability_zone = "ap-south-2a"

  tags = {
    Name = "Hyd2_subnet"
  }
}



output "public_subnet_id" {
  value = aws_subnet.Hyd2_subnet.id
  
}