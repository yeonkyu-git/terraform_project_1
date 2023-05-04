// WEB Server ALB
resource "aws_lb" "web-alb" {
  name = "${var.prefix}-main-web-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.alb_sg]
  # subnets            = [for subnet in var.public_subnet_ids : subnet.id]
  subnets = var.public_subnet_ids

  enable_deletion_protection = false

  tags = {
    Name = "${var.prefix}-main-web-alb"
    Managed_by =   "terraform"
    Schedule =   "off-at-18"
  }
}

// ALB Listener
resource "aws_lb_listener" "web_listener_80" {
  load_balancer_arn = aws_lb.web-alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web-tg.arn
  }
}

// Target Group
resource "aws_lb_target_group" "web-tg" {
  port                 = 80
  protocol             = "HTTP"
  vpc_id               = var.vpc_id

  health_check {
    path = "/"
    port = "traffic-port"
    protocol = "HTTP"
  }

  tags = {
    Name = "${var.prefix}-main-web-tg"
    Managed_by =   "terraform"
  }
}

// Target Group Attachment - 인스턴스 연결
resource "aws_lb_target_group_attachment" "tg-attachment" {
  count = length(var.instance_ids)

  target_group_arn = aws_lb_target_group.web-tg.arn
  target_id        = var.instance_ids[count.index]
  port             = 80
}