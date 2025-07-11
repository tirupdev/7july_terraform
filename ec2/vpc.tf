# File: 7july_terraform/ec2/vpc.tf
resource "aws_vpc" "Hyderabad2" {
  cidr_block = "10.10.10.0/24" # Example CIDR block, adjust as needed
  tags = {
    Name = "Hyderabad2"
    environment = "dev"
  }
}

resource "aws_subnet" "Hyderabad2_subnet" {
  vpc_id            = aws_vpc.Hyderabad2.id
  cidr_block        = "10.10.10.0/26"
  availability_zone = "ap-south-2a"

  tags = {

    Name        = "Hyderabad2_subnet"
    environment = "dev"
  }
}

resource "aws_internet_gateway" "Hyderabad2_igw" {
  vpc_id = aws_vpc.Hyderabad2.id

  tags = {
    Name        = "Hyderabad2_igw"
    environment = "dev"
  }
}

resource "aws_route_table" "Hyderabad2_route_table" {
  vpc_id = aws_vpc.Hyderabad2.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.Hyderabad2_igw.id
  }

  tags = {
    Name        = "Hyderabad2_route_table"
    environment = "dev"
  }
}
resource "aws_route_table_association" "Hyderabad2_subnet_association" {
  subnet_id      = aws_subnet.Hyderabad2_subnet.id
  route_table_id = aws_route_table.Hyderabad2_route_table.id
}