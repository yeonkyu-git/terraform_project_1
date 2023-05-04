// Private Subnet
resource "aws_subnet" "private_subnet" {
  count = length(var.private_subnets)

  vpc_id     = aws_vpc.main.id
  cidr_block = lookup(var.private_subnets[count.index], "cidr")
  availability_zone = lookup(var.private_subnets[count.index], "availability_zone")

  tags = {
    Name = "${var.prefix}-prod-privateSubnet-${count.index+1}"
    Managed_by = "terraform"
  }
}