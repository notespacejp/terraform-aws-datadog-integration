# terraform-aws-datadog-integration

## Description

Module to set up datadog aws integration

## Document Update

```shell
terraform-docs markdown --output-file ./README.md .
```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.0 |
| <a name="requirement_datadog"></a> [datadog](#requirement\_datadog) | >= 3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.0 |
| <a name="provider_datadog"></a> [datadog](#provider\_datadog) | >= 3.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_policy.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [datadog_integration_aws.this](https://registry.terraform.io/providers/DataDog/datadog/latest/docs/resources/integration_aws) | resource |
| [aws_caller_identity.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.assume_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.permissions](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_dd_account_ids"></a> [dd\_account\_ids](#input\_dd\_account\_ids) | Datadog aws account ids (Default: AP1 AWS account ids) | `list(string)` | <pre>[<br>  "464622532012",<br>  "417141415827"<br>]</pre> | no |
| <a name="input_policy_name"></a> [policy\_name](#input\_policy\_name) | aws policy name | `string` | `"DatadogAWSIntegrationPolicy"` | no |
| <a name="input_role_name"></a> [role\_name](#input\_role\_name) | aws role name | `string` | `"DatadogAWSIntegrationRole"` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->