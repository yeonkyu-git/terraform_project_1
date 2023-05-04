// Public Subnet
resource "aws_subnet" "public_subnet" {
  count = length(var.public_subnets)

  vpc_id     = aws_vpc.main.id
  cidr_block = lookup(var.public_subnets[count.index], "cidr")
  availability_zone = lookup(var.public_subnets[count.index], "availability_zone")

  tags = {
    Name = "${var.prefix}-network-publicSubnet-${count.index+1}"
    Managed_by = "terraform"
  }
}

// Private Subnet
resource "aws_subnet" "private_subnet" {
  count = length(var.private_subnets)

  vpc_id     = aws_vpc.main.id
  cidr_block = lookup(var.private_subnets[count.index], "cidr")
  availability_zone = lookup(var.private_subnets[count.index], "availability_zone")

  tags = {
    Name = "${var.prefix}-network-privateSubnet-${count.index+1}"
    Managed_by = "terraform"
  }
}