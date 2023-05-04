variable "prefix" {}
variable "keypair_name" {}
variable "instance_type" {}
variable "bastion_sg" {}
variable "web_sg" {}

variable "public_subnet_ids" {
  type = list(string)
}

variable "private_subnet_ids" {
  type = list(string)
}

