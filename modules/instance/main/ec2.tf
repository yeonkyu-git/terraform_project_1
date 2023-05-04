// Bastion host
resource "aws_instance" "bastion" {
  ami                             =   data.aws_ami.al.id
  instance_type                   =   var.instance_type
  key_name                        =   var.keypair_name

  associate_public_ip_address     =   true
  subnet_id                       =   var.public_subnet_ids[0]
  vpc_security_group_ids          =   [var.bastion_sg]


  tags = {
    Name                        =   "${var.prefix}-main-bastion-host"
    Managed_by                  =   "terraform"
    Schedule                    =   "off-at-18"
  }
}

// Web Server
resource "aws_instance" "webserver" {
    count                           =   length(var.private_subnet_ids)
    ami                             =   data.aws_ami.al.id
    instance_type                   =   var.instance_type

    associate_public_ip_address     =   false
    
    subnet_id                       =   element(var.private_subnet_ids, count.index)
    
    key_name                        =   var.keypair_name
    vpc_security_group_ids          =   [var.web_sg]

    user_data                       =   data.template_file.webserver_init.rendered

    tags = {
        Name                        =   "${var.prefix}-main-web-host-${count.index+1}"
        Managed_by                  =   "terraform"
        Schedule                    =   "off-at-18"
    }
}