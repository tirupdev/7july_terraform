resource "aws_vpc" "main" {
  cidr_block = var.cidr_block


  tags = {
    Name = "Hyd2"
  }
}

resource "aws_subnet" "main" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.cidr_block
  availability_zone = "ap-south-2a"

  tags = {
    Name = "Hyd2_subnet"
  }
}
