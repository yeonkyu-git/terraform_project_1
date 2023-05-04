data "template_file" "webserver_init" {
    template = file("${path.module}/templates/userdata.sh.tpl")
}

data "aws_ami" "al" {
   most_recent = true
   owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}