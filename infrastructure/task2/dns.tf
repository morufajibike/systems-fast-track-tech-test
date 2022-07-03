resource "aws_route53_record" "wwww" {
  zone_id = data.aws_ssm_parameter.route53_hosted_id.value
  name    = data.aws_ssm_parameter.route53_hosted_name.value
  type    = "A"

  alias {
    name                   = aws_alb.app_alb.dns_name
    zone_id                = aws_alb.app_alb.zone_id
    evaluate_target_health = true
  }
}
