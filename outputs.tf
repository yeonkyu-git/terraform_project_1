output "alb_domain" {
  description = "domain for alb"
  value = module.main_alb.alb_domain
}

output "alb_zone" {
  description = "zone for alb"
  value = module.main_alb.alb_zone
}
