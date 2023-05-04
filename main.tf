// 예시
module "main_network" {
    source              =   "./modules/network/main"

    // 공통
    prefix              =   var.prefix

    // VPC
    vpc_cidr            =   var.main_vpc_cidr
    
    // Subnet
    public_subnets      =   var.main_public_subnets
    private_subnets     =   var.main_private_subnets
    
    // Security Group
    myip  =   var.myip
}

module "prod_network" {
    source              =   "./modules/network/prod"

    // 공통
    prefix              =   var.prefix

    // VPC
    vpc_cidr            =   var.prod_vpc_cidr
    
    // Subnet
    private_subnets     =   var.prod_private_subnets
    
    // Security Group
    myip  =   var.myip
}