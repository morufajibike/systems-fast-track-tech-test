
/* variables */

variable "region" {
  description = "AWS region to deploy resources to"
  type        = string
  default     = "eu-west-2"
}

variable "vpc_id_ssm_path" {
  description = "The SSM path of the VPC"
  type        = string
  default     = "/mmt/vpc/vpc_id"
}

variable "public_subnet_ids_ssm_path" {
  description = "The SSM path public subnet ids inside the VPC"
  type        = string
  default     = "/mmt/subnets/public/subnet-ids"
}

variable "private_subnet_ids_ssm_path" {
  description = "The SSM path of private subnet ids inside the VPC"
  type        = string
  default     = "/mmt/subnets/private/subnet-ids"
}

variable "route53_hosted_id_ssm_path" {
  description = "The SSM path of the route53 hosted zone id"
  type        = string
  default     = "/mmt/dns/r53_zone_id"
}

variable "route53_hosted_name_ssm_path" {
  description = "The SSM path of the route53 hosted zone name"
  type        = string
  default     = "/mmt/dns/r53_zone_name"
}

variable "acm_certificate_arn_ssm_path" {
  description = "The SSM path of the ARN of the ACM certificate"
  type        = string
  default     = "/mmt/acm/tech_test_ssl_arn"
}

variable "service_name" {
  type    = string
  default = "mmtdigital"
}

variable "container_port" {
  description = "The port the httpd image is running on"
  type        = string
  default     = "80"
}

variable "host_port" {
  description = "The host port exposed by the container"
  type        = string
  default     = "8080"
}

variable "ecs_task_minimum_count" {
  description = "ECS task minimum count"
  type        = string
  default     = 3
}

variable "ecs_task_maximum_count" {
  description = "ECS task minimum count"
  type        = string
  default     = 6
}
