/* Security groups with ingress controls */

#tfsec:ignore:AWS008 => Warning ignored because ALB has to be reachable from the internet
resource "aws_security_group" "allow_https_to_alb" {
  name        = "allow_https_to_alb"
  description = "Allow HTTPS inbound traffic"
  vpc_id      = data.aws_ssm_parameter.vpc_id.value

  ingress {
    description      = "Allow HTTPS requests from outside world"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_https_to_alb"
  }
}

resource "aws_security_group" "alb_to_ecs_host_sg" {
  name        = "alb_to_ecs_host_sg"
  description = "Allow ALB access to the ECS service"
  vpc_id      = data.aws_ssm_parameter.vpc_id.value

  ingress {
    description     = "Allow access from ALB to the ECS hosts"
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    security_groups = [aws_security_group.allow_https_to_alb.id]
  }

  tags = {
    Name = "alb_to_ecs_host_sg"
  }
}
