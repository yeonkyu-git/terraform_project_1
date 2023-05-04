## Main 
module "main_network" {
    source              =   "./modules/network/main"

    // 공통
    prefix              =   var.prefix

    // VPC
    vpc_cidr            =   var.main_vpc_cidr
    prod_vpc_cidr       =   var.prod_vpc_cidr
    
    // Subnet
    public_subnets      =   var.main_public_subnets
    private_subnets     =   var.main_private_subnets
    
    // Security Group
    myip  =   var.myip

    // TGW
    tgw_id = module.tgw.tgw_id
}

module "main_instance" {
    source              =   "./modules/instance/main"

    // 공통
    prefix              =   var.prefix

    // 인스턴스
    keypair_name = var.keypair_name
    instance_type = var.instance_type
    public_subnet_ids = module.main_network.public_subnet_ids
    private_subnet_ids = module.main_network.private_subnet_ids
    bastion_sg = module.main_network.bastion_host_sg_id
    web_sg = module.main_network.web_sg_id
}

module "main_alb" {
    source              =   "./modules/alb/main"

    // 공통
    prefix              =   var.prefix

    // 인스턴스
    alb_sg              =   module.main_network.alb_sg_id
    public_subnet_ids = module.main_network.public_subnet_ids
    vpc_id             = module.main_network.vpc_id
    instance_ids = module.main_instance.webserver_instances_ids
}

// Prod
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
    bastion_host_ip = module.main_instance.bastion_instance_private_ip

    // TGW
    tgw_id = module.tgw.tgw_id
}

module "prod_instance" {
    source              =   "./modules/instance/prod"

    // 공통
    prefix              =   var.prefix

    // 인스턴스
    keypair_name = var.keypair_name
    instance_type = var.instance_type
    private_subnet_ids = module.prod_network.private_subnet_ids
    web_sg = module.prod_network.web_sg_id
}

// 공통
module "tgw" {
      source              =   "./modules/network/tgw"

    // 공통
    prefix              =   var.prefix

    // Transit Gateway 
    main_vpc_id             = module.main_network.vpc_id
    main_private_subnet_ids = module.main_network.private_subnet_ids

    prod_vpc_id             = module.prod_network.vpc_id
    prod_private_subnet_ids = module.prod_network.private_subnet_ids
}

module "route53" {
    source              =   "./modules/network/route53"

    // 공통
    prefix              =   var.prefix

    main_vpc_id             = module.main_network.vpc_id
    prod_vpc_id             = module.prod_network.vpc_id
    alb_domain              = module.main_alb.alb_domain
    alb_zone                = module.main_alb.alb_zone

}