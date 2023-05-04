// Private Route Table
resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.prefix}-prod-private-route-table"
    Managed_by = "terraform"
  }
}

resource "aws_route" "main_private_tgw_route" {
  route_table_id            = aws_route_table.private_route_table.id
  destination_cidr_block    = "0.0.0.0/0"
  transit_gateway_id = var.tgw_id
  depends_on                = [var.tgw_id]
}


resource "aws_route_table_association" "private-route-table-asso" {
  count = length(aws_subnet.private_subnet)

  subnet_id      = aws_subnet.private_subnet[count.index].id
  route_table_id = aws_route_table.private_route_table.id
}