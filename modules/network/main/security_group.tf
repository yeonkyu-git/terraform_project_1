// Security Group - Bastion Host
resource "aws_security_group" "bastion-host-sg" {
  description = "bastion host sg"
  vpc_id      = aws_vpc.main.id

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "${var.prefix}-network-bastion-sg"
    Managed_by = "terraform"
  }
}

resource "aws_security_group_rule" "bastion-host-sg-ssh-rule" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = var.myip
  security_group_id = aws_security_group.bastion-host-sg.id
}


// Security Group - ALB
resource "aws_security_group" "alb-sg" {
  description = "alb sg"
  vpc_id      = aws_vpc.main.id

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "${var.prefix}-network-alb-sg"
    Managed_by = "terraform"
  }
}

resource "aws_security_group_rule" "alb-sg-http-rule" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.alb-sg.id
}

resource "aws_security_group_rule" "alb-sg-https-rule" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.alb-sg.id
}


// Security Group - Web Server
resource "aws_security_group" "web-sg" {
  description = "web sg"
  vpc_id      = aws_vpc.main.id

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "${var.prefix}-network-web-sg"
    Managed_by = "terraform"
  }
}

resource "aws_security_group_rule" "web-sg-http-rule" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  source_security_group_id = aws_security_group.alb-sg.id
  security_group_id = aws_security_group.web-sg.id
}

resource "aws_security_group_rule" "web-sg-https-rule" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  source_security_group_id = aws_security_group.alb-sg.id
  security_group_id = aws_security_group.web-sg.id
}

resource "aws_security_group_rule" "web-sg-ssh-rule" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id = aws_security_group.bastion-host-sg.id
  security_group_id = aws_security_group.web-sg.id
}
