// Web Server
resource "aws_instance" "webserver" {
    ami                             =   data.aws_ami.al.id
    instance_type                   =   var.instance_type

    associate_public_ip_address     =   false
    
    subnet_id                       =   element(var.private_subnet_ids, 0)
    
    key_name                        =   var.keypair_name
    vpc_security_group_ids          =   [var.web_sg]
    tags = {
        Name                        =   "${var.prefix}-prod-web-host"
        Managed_by                  =   "terraform"
        Schedule                    =   "off-at-18"
    }
}