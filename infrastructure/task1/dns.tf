resource "aws_route53_record" "wwww" {
  zone_id = var.route53_hosted_id
  name    = var.route53_hosted_name
  type    = "A"

  alias {
    name                   = aws_alb.app_alb.dns_name
    zone_id                = aws_alb.app_alb.zone_id
    evaluate_target_health = true
  }
}
