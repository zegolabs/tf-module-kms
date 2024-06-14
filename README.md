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
| [aws_kms_alias.alias](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_alias) | resource |
| [aws_kms_key.key](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key) | resource |
| [aws_secretsmanager_secret.secret](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.secret](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.secret_kms](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allowed_readers"></a> [allowed\_readers](#input\_allowed\_readers) | Namespaced services allowed to read this secret | <pre>list(object(<br>    {<br>      namespace = string<br>      service   = string<br>    }<br>  ))</pre> | `[]` | no |
| <a name="input_cost_center"></a> [cost\_center](#input\_cost\_center) | The cost center for this secret | `string` | n/a | yes |
| <a name="input_non_meta_tags_allowed"></a> [non\_meta\_tags\_allowed](#input\_non\_meta\_tags\_allowed) | Allow tags to omit meta.zego.tools/ prefix | `bool` | `false` | no |
| <a name="input_owner"></a> [owner](#input\_owner) | The team that owns this secret | `string` | n/a | yes |
| <a name="input_secret_name"></a> [secret\_name](#input\_secret\_name) | Name of the secret to create | `string` | n/a | yes |

## Outputs

No outputs.
