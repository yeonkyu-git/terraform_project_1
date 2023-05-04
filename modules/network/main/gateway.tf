// Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.prefix}-network-igw"
    Managed_by = "terraform"
  }
}

// NAT Gateway
resource "aws_eip" "nat-eip" {
  vpc               =   true
  depends_on        =   [aws_internet_gateway.igw]

  tags = {
    Name = "${var.prefix}-ngw-ip"
    Managed_by = "terraform"
  }
}


resource "aws_nat_gateway" "ngw" {
  allocation_id = aws_eip.nat-eip.id
  subnet_id     = aws_subnet.public_subnet.1.id

  tags = {
    Name = "${var.prefix}-network-ngw"
    Managed_by = "terraform"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.igw]
}