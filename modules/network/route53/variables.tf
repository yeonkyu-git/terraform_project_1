variable "prefix" {}

variable "main_vpc_id" {
  type = string
}

variable "prod_vpc_id" {
  type = string
}

variable "alb_domain" {
  type = string
}

variable "alb_zone" {
  type = string
}