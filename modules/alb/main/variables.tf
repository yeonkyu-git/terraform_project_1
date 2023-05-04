variable "prefix" {}
variable "alb_sg" {}

variable "public_subnet_ids" {
  type = list(string)
}

variable "vpc_id" {}

variable "instance_ids" {
  type = list(string)
}