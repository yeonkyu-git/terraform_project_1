variable "prefix" {}
variable "keypair_name" {}
variable "instance_type" {}
variable "web_sg" {}

variable "private_subnet_ids" {
  type = list(string)
}

