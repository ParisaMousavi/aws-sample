## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 3.50.0 |
| <a name="provider_null"></a> [null](#provider\_null) | 3.1.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_s3_bucket.s3_bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [null_resource.empty_storage](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_costcenter"></a> [costcenter](#input\_costcenter) | n/a | `string` | `"ABC000CBA"` | no |
| <a name="input_domainname"></a> [domainname](#input\_domainname) | ---------------------------------------------------- Specific variables ---------------------------------------------------- | `string` | `"cc-fco.de"` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | n/a | `string` | `"ACC"` | no |
| <a name="input_imagenames"></a> [imagenames](#input\_imagenames) | n/a | `string` | `"opportunity,customer,service,appsetting"` | no |
| <a name="input_projectname"></a> [projectname](#input\_projectname) | ---------------------------------------------------- General variable ---------------------------------------------------- | `string` | `"FCOM"` | no |
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | `"EUC1"` | no |
| <a name="input_tag"></a> [tag](#input\_tag) | n/a | `string` | `"dev"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_bucket_regional_domain_name"></a> [bucket\_regional\_domain\_name](#output\_bucket\_regional\_domain\_name) | n/a |
| <a name="output_s3_bucket_name"></a> [s3\_bucket\_name](#output\_s3\_bucket\_name) | n/a |
