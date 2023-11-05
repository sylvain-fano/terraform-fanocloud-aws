# terraform-aws-efs

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~>1.3.4 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~>4.40.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~>4.40.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_efs_file_system.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/efs_file_system) | resource |
| [aws_efs_mount_target.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/efs_mount_target) | resource |
| [aws_security_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_db_context"></a> [db\_context](#input\_db\_context) | DB outputs | `map(any)` | n/a | yes |
| <a name="input_efs_context"></a> [efs\_context](#input\_efs\_context) | EFS  outputs | `map(any)` | n/a | yes |
| <a name="input_env"></a> [env](#input\_env) | Environment | `string` | `"prod"` | no |
| <a name="input_project_prefix"></a> [project\_prefix](#input\_project\_prefix) | Project name to prefix created resources with | `any` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | AWS region | `string` | `"eu-west-3"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map` | `{}` | no |
| <a name="input_vpc_context"></a> [vpc\_context](#input\_vpc\_context) | VPC outputs | `map(any)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_efs_id"></a> [efs\_id](#output\_efs\_id) | EFS filesystem ID |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
