// VPC Outputs
output "vpc_id" {
  description = "The ID of main vpc"
  value = aws_vpc.main.id
}

// Subnet Outpus
output "private_subnet_ids" {
  description = "The List ids of public subnets"
  value = aws_subnet.private_subnet.*.id
}

// Security group
output "web_sg_id" {
  description = "Thd id of WEB SG"
  value = aws_security_group.web-sg.id
}