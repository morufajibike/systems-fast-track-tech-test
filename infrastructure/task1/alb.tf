/* Application Load balancer and related resources */

#tfsec:ignore:AWS005 => Warning ignored because ALB has to be reachable from the internet
resource "aws_alb" "app_alb" {
  #checkov:skip=CKV_AWS_91:No bucket was provided for configuring access logs

  name                             = "app-alb"
  load_balancer_type               = "application"
  subnets                          = var.public_subnet_ids
  security_groups                  = [aws_security_group.allow_https_to_alb.id]
  enable_cross_zone_load_balancing = true
  drop_invalid_header_fields       = true
  enable_deletion_protection       = true
}

resource "aws_alb_target_group" "app_alb_tg" {
  name        = "app-alb-tg"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip"

  health_check {
    healthy_threshold   = "3"
    interval            = "10"
    protocol            = "HTTP"
    matcher             = "200"
    timeout             = "3"
    path                = "/"
    unhealthy_threshold = "2"
    port                = var.container_port
  }

  depends_on = [
    aws_alb.app_alb
  ]

  lifecycle {
    create_before_destroy = true
  }
}

/*
HTTP (80) ALB listener with a redirect to HTTPS (443).
THis makes app reachable via HTTP but redirected to HTTPS
*/
resource "aws_alb_listener" "app_alb_listener_http" {
  load_balancer_arn = aws_alb.app_alb.id
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = 443
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

resource "aws_alb_listener" "app_alb_listener_https" {
  load_balancer_arn = aws_alb.app_alb.id
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-TLS-1-2-2017-01"
  certificate_arn   = var.acm_certificate_arn

  default_action {
    target_group_arn = aws_alb_target_group.app_alb_tg.arn
    type             = "forward"
  }
}
