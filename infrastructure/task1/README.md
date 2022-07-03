# Task 1: Infrastructure as Code Template

## Infrastructure
Infrastructure configuration with Route53 DNS record for proxying requests to an Application Load Balancer on HTTPS (443) to a listener rule with a target group that forwards traffic on port 80 to an ECS cluster on Fargate running a httpd docker image.

General Fargate capacity provider is used for the ECS cluster.

### Requirements

- Install pre-commit with python3 and pip3
    ```
    pip3 install pre-commit --upgrade
    ```

- Install pre-commit hook dependencies for your operating system (OS)

    #### MacOS
    ```
    brew tap liamg/tfsec
    brew install pre-commit gawk terraform-docs tflint tfsec coreutils checkov terraform-docs
    ```

    #### Other OS
    You may be able to install wuth `Chocolatey`, `snap` or `apt-get` depending on your OS.

- Install Git pre-commit hooks
Run the command: `pre-commit install` from the root directory with the `.pre-commit-config.yaml` file.

## Assumptions
- AWS region assumed to be `eu-west-2`.
- IAM user/role assumed to have all the necessary permission to create the defined resources.
- Autoscaling target and policy configured to use `ECSServiceAverageCPUUtilizatio` metric.
- Terraform backend configuration not added; local to be used by default.

## Improvements
- Application load balancer and ECS task logs should be sent to cloudwatch.
- Add terraform backend configuration with an s3 bucket to hold state files.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0, <= 1.0.9 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 3.71.0 |
| <a name="provider_template"></a> [template](#provider\_template) | 2.2.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_alb.app_alb](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/alb) | resource |
| [aws_alb_listener.app_alb_listener_http](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/alb_listener) | resource |
| [aws_alb_listener.app_alb_listener_https](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/alb_listener) | resource |
| [aws_alb_target_group.app_alb_tg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/alb_target_group) | resource |
| [aws_appautoscaling_policy.ecs_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appautoscaling_policy) | resource |
| [aws_appautoscaling_target.ecs_target](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appautoscaling_target) | resource |
| [aws_ecs_cluster.cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_cluster) | resource |
| [aws_ecs_service.service](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_service) | resource |
| [aws_ecs_task_definition.task](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_task_definition) | resource |
| [aws_iam_role.ecs_task_execution_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_route53_record.wwww](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_security_group.alb_to_ecs_host_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.allow_https_to_alb](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_vpc.vpc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc) | data source |
| [template_file.task_definition](https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_acm_certificate_arn"></a> [acm\_certificate\_arn](#input\_acm\_certificate\_arn) | The ARN of the ACM certificate | `string` | `"arn:aws:acm:eu-west-1:8877665544:certificate/123456789012-1234-1234-1234-12345678"` | no |
| <a name="input_container_port"></a> [container\_port](#input\_container\_port) | The port the httpd image is running on | `string` | `"80"` | no |
| <a name="input_ecs_task_maximum_count"></a> [ecs\_task\_maximum\_count](#input\_ecs\_task\_maximum\_count) | ECS task minimum count | `string` | `6` | no |
| <a name="input_ecs_task_minimum_count"></a> [ecs\_task\_minimum\_count](#input\_ecs\_task\_minimum\_count) | ECS task minimum count | `string` | `3` | no |
| <a name="input_host_port"></a> [host\_port](#input\_host\_port) | The host port exposed by the container | `string` | `"8080"` | no |
| <a name="input_private_subnet_ids"></a> [private\_subnet\_ids](#input\_private\_subnet\_ids) | A list of private subnet ids inside the VPC | `list(string)` | <pre>[<br>  "priv--whyn6rn7eq",<br>  "priv--uuz4yz54wx",<br>  "priv--uvoary5wdo"<br>]</pre> | no |
| <a name="input_public_subnet_ids"></a> [public\_subnet\_ids](#input\_public\_subnet\_ids) | A list of public subnet ids inside the VPC | `list(string)` | <pre>[<br>  "pub--7eqwhyn6rn",<br>  "pub--54wxuuz4yz",<br>  "pub--y5wdouvoar"<br>]</pre> | no |
| <a name="input_region"></a> [region](#input\_region) | AWS region to deploy resources to | `string` | `"eu-west-2"` | no |
| <a name="input_route53_hosted_id"></a> [route53\_hosted\_id](#input\_route53\_hosted\_id) | The ID of the route53 hosted zone | `string` | `"xcf4435z"` | no |
| <a name="input_route53_hosted_name"></a> [route53\_hosted\_name](#input\_route53\_hosted\_name) | The name of the route53 hosted zone | `string` | `"mmt_tech_test_zone"` | no |
| <a name="input_service_name"></a> [service\_name](#input\_service\_name) | n/a | `string` | `"mmtdigital"` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | The ID of the VPC | `string` | `"x567hhdz"` | no |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
