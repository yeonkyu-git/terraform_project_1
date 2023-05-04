variable "prefix" {}
variable "region" {}
variable "access_key" {}
variable "secret_key" {}

# Main Network
variable "main_vpc_cidr" {}
variable "main_public_subnets" {
    type = list(object({
        cidr                =   string
        availability_zone   =   string
    }))
}

variable "main_private_subnets" {
    type = list(object({
        cidr                =   string
        availability_zone   =   string
    }))
}

# Prod Network
variable "prod_vpc_cidr" {}
variable "prod_private_subnets" {
    type = list(object({
        cidr                =   string
        availability_zone   =   string
    }))
}

variable "myip" {
    type = list(string)
}

variable "instance_type" {}
variable "keypair_name" {}
