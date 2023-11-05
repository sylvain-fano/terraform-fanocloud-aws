# terraform-aws-keypair

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_key_pair.ec2_keypair](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/key_pair) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_keypair_name"></a> [keypair\_name](#input\_keypair\_name) | Name of your Keypair | `string` | `"terraform-kp"` | no |
| <a name="input_keypair_path"></a> [keypair\_path](#input\_keypair\_path) | Path to public key on your local machine | `any` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | AWS region | `string` | `"eu-west-3"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_kp_name"></a> [kp\_name](#output\_kp\_name) | Keypair name |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
