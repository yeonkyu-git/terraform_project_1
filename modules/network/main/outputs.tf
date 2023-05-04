// VPC Outputs
output "vpc_id" {
  description = "The ID of main vpc"
  value = aws_vpc.main.id
}

// Subnet Outpus
output "public_subnet_ids" {
  description = "The List ids of public subnets"
  value = aws_subnet.public_subnet.*.id
}

output "private_subnet_ids" {
  description = "The List ids of public subnets"
  value = aws_subnet.private_subnet.*.id
}

// Gateway
output "igw_id" {
  description = "The id of IGW"
  value = aws_internet_gateway.igw.id
}

output "ngw_id" {
  description = "The id of NGW"
  value = aws_nat_gateway.ngw.id
}

output "ngw_ip" {
  description = "The IP of NGW"
  value = aws_nat_gateway.ngw.public_ip
}

// Security group
output "bastion_host_sg_id" {
  description = "Thd id of Bastion Host SG"
  value = aws_security_group.bastion-host-sg.id
}

output "alb_sg_id" {
  description = "Thd id of ALB SG"
  value = aws_security_group.alb-sg.id
}

output "web_sg_id" {
  description = "Thd id of WEB SG"
  value = aws_security_group.web-sg.id
}