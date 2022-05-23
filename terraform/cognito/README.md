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
| [aws_cognito_user_group.Admingroup](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cognito_user_group) | resource |
| [aws_cognito_user_group.Ciscogroup](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cognito_user_group) | resource |
| [aws_cognito_user_group.Computacentergroup](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cognito_user_group) | resource |
| [aws_cognito_user_pool.userpool](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cognito_user_pool) | resource |
| [aws_cognito_user_pool_client.client](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cognito_user_pool_client) | resource |
| [aws_cognito_user_pool_domain.domain](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cognito_user_pool_domain) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_costcenter"></a> [costcenter](#input\_costcenter) | n/a | `string` | `"ABC000CBA"` | no |
| <a name="input_domainname"></a> [domainname](#input\_domainname) | ---------------------------------------------------- Specific variables ---------------------------------------------------- | `string` | `"cc-fco.de"` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | n/a | `string` | `"ACC"` | no |
| <a name="input_imagenames"></a> [imagenames](#input\_imagenames) | n/a | `string` | `"opportunity,customer,service,appsetting"` | no |
| <a name="input_projectname"></a> [projectname](#input\_projectname) | ---------------------------------------------------- General variable ---------------------------------------------------- | `string` | `"FCOM"` | no |
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | `"EUC1"` | no |
| <a name="input_tag"></a> [tag](#input\_tag) | n/a | `string` | `"DEV"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_audience"></a> [audience](#output\_audience) | n/a |
| <a name="output_poolid"></a> [poolid](#output\_poolid) | n/a |
