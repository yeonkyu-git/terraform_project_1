// Public Route Table
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "${var.prefix}-network-public-route-table"
    Managed_by = "terraform"
  }
}

resource "aws_route" "main_public_tgw_route" {
  route_table_id            = aws_route_table.public_route_table.id
  destination_cidr_block    = var.prod_vpc_cidr
  transit_gateway_id = var.tgw_id
  depends_on                = [var.tgw_id]
}

resource "aws_route_table_association" "public-route-table-asso" {
  count = length(aws_subnet.public_subnet)

  subnet_id      = aws_subnet.public_subnet[count.index].id
  route_table_id = aws_route_table.public_route_table.id
}

// Private Route Table
resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.ngw.id
  }

  tags = {
    Name = "${var.prefix}-network-private-route-table"
    Managed_by = "terraform"
  }
}

resource "aws_route" "main_private_tgw_route" {
  route_table_id            = aws_route_table.private_route_table.id
  destination_cidr_block    = var.prod_vpc_cidr
  transit_gateway_id = var.tgw_id
  depends_on                = [var.tgw_id]
}

resource "aws_route_table_association" "private-route-table-asso" {
  count = length(aws_subnet.private_subnet)

  subnet_id      = aws_subnet.private_subnet[count.index].id
  route_table_id = aws_route_table.private_route_table.id
}