/* Data sources used to information about existing resources outside of terraform */

data "aws_vpc" "vpc" {
  id = var.vpc_id
}

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
