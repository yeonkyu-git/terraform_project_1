variable "prefix" {}

# prod Network
variable "vpc_cidr" {}
variable "private_subnets" {
    type = list(object({
        cidr                =   string
        availability_zone   =   string
    }))
}
variable "myip" {
    type = list(string)
}


variable "bastion_host_ip" {
    type = string
}