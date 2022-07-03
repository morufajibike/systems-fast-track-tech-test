/* Data sources used to information about existing resources outside of terraform */

data "template_file" "task_definition" {
  template = file("ecs-task-definition.json")
  vars = {

    app_name           = var.service_name
    fargate_cpu        = 256
    fargate_memory     = 512
    app_container_port = var.container_port
    app_host_port      = var.host_port

    app_dns_lb = aws_alb.app_alb.dns_name

    region = var.region

    image_name    = "httpd"
    image_version = "latest"
  }
}

data "aws_ssm_parameter" "vpc_id" {
  name = var.vpc_id_ssm_path
}

data "aws_ssm_parameter" "public_subnet_ids" {
  name = var.public_subnet_ids_ssm_path
}

data "aws_ssm_parameter" "private_subnet_ids" {
  name = var.private_subnet_ids_ssm_path
}

data "aws_ssm_parameter" "route53_hosted_id" {
  name = var.route53_hosted_id_ssm_path
}

data "aws_ssm_parameter" "route53_hosted_name" {
  name = var.route53_hosted_name_ssm_path
}

data "aws_ssm_parameter" "acm_certificate_arn" {
  name = var.acm_certificate_arn_ssm_path
}
