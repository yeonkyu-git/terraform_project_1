output "alb_domain" {
  description = "domain for alb"
  value = aws_lb.web-alb.dns_name
}