/* variables */

variable "region" {
  description = "AWS region to deploy resources to"
  type        = string
  default     = "eu-west-2"
}

variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
  default     = "x567hhdz"
}

variable "public_subnet_ids" {
  description = "A list of public subnet ids inside the VPC"
  type        = list(string)
  default     = ["pub--7eqwhyn6rn", "pub--54wxuuz4yz", "pub--y5wdouvoar"]
}

variable "private_subnet_ids" {
  description = "A list of private subnet ids inside the VPC"
  type        = list(string)
  default     = ["priv--whyn6rn7eq", "priv--uuz4yz54wx", "priv--uvoary5wdo"]
}

variable "route53_hosted_id" {
  description = "The ID of the route53 hosted zone"
  type        = string
  default     = "xcf4435z"
}

variable "route53_hosted_name" {
  description = "The name of the route53 hosted zone"
  type        = string
  default     = "mmt_tech_test_zone"
}

variable "acm_certificate_arn" {
  description = "The ARN of the ACM certificate"
  type        = string
  default     = "arn:aws:acm:eu-west-1:8877665544:certificate/123456789012-1234-1234-1234-12345678"
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
