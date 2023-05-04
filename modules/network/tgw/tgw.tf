// TGW
resource "aws_ec2_transit_gateway" "tgw" {
  description = "main-prod-tgw"

  dns_support = "enable"
  vpn_ecmp_support = "enable"
  default_route_table_association = "enable"
  default_route_table_propagation = "enable"

  tags = {
    Name = "${var.prefix}-main-prod-tgw"
  }
}

# resource "aws_ec2_transit_gateway_route_table" "tgw-rt" {
#   transit_gateway_id = aws_ec2_transit_gateway.tgw.id

#   default_association_route_table = true
# }

// TGW Attachment
resource "aws_ec2_transit_gateway_vpc_attachment" "main-tgw-attchatment" {
  subnet_ids         = var.main_private_subnet_ids
  transit_gateway_id = aws_ec2_transit_gateway.tgw.id
  vpc_id             = var.main_vpc_id

  tags = {
    Name = "${var.prefix}-main-tgw-attachment"
  }
}

resource "aws_ec2_transit_gateway_vpc_attachment" "prod-tgw-attchatment" {
  subnet_ids         = var.prod_private_subnet_ids
  transit_gateway_id = aws_ec2_transit_gateway.tgw.id
  vpc_id             = var.prod_vpc_id

  tags = {
    Name = "${var.prefix}-prod-tgw-attachment"
  }
}

// TGW Route (Prod -> Main 0.0.0.0/0)
resource "aws_ec2_transit_gateway_route" "tgw-prod-route" {
  destination_cidr_block         = "0.0.0.0/0"
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.main-tgw-attchatment.id # 빠져나가는 목적지
  transit_gateway_route_table_id = aws_ec2_transit_gateway.tgw.association_default_route_table_id

  depends_on = [ aws_ec2_transit_gateway_vpc_attachment.prod-tgw-attchatment ]
}


