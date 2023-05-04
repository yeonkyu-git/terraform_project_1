variable "prefix" {}

variable "main_vpc_id" {
  type = string
}
variable "main_private_subnet_ids" {
  type = list(string)
}

variable "prod_vpc_id" {
  type = string
}
variable "prod_private_subnet_ids" {
  type = list(string)
}

