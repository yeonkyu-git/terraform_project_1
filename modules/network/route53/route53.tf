# Route 53 Private zone 
resource "aws_route53_zone" "route53_private_zone" {
  name = "yeonkyu.com"

  vpc {
    vpc_id = var.main_vpc_id
  }
}

# Connect to prod vpc <-> private zone 
resource "aws_route53_zone_association" "secondary" {
  zone_id = aws_route53_zone.route53_private_zone.id
  vpc_id  = var.prod_vpc_id
}

# A Record
resource "aws_route53_record" "domain" {
  zone_id = aws_route53_zone.route53_private_zone.zone_id
  name    = "www"
  type    = "A"
  
  alias {
    name                   = var.alb_domain
    zone_id                = var.alb_zone
    evaluate_target_health = true
  }

}
