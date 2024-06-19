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
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.secret_kms](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_roles.developer_sso_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_roles) | data source |
| [aws_iam_roles.syseng_admin_sso_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_roles) | data source |
| [aws_iam_roles.syseng_power_user_sso_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_roles) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allowed_reader_roles"></a> [allowed\_reader\_roles](#input\_allowed\_reader\_roles) | A list of roles allowed to decrypt with this key | `list(string)` | `[]` | no |
| <a name="input_allowed_readers"></a> [allowed\_readers](#input\_allowed\_readers) | Namespaced services allowed to decrypt with this key | <pre>list(object(<br>    {<br>      namespace = string<br>      service   = string<br>    }<br>  ))</pre> | `[]` | no |
| <a name="input_cost_center"></a> [cost\_center](#input\_cost\_center) | The cost center for this key | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Name of the secrets access group this key is for | `string` | n/a | yes |
| <a name="input_owner"></a> [owner](#input\_owner) | The team that owns this key | `string` | n/a | yes |
| <a name="input_protected_owners"></a> [protected\_owners](#input\_protected\_owners) | Secrets owned by those in this list will not be accessible by the user\_roles | `list(string)` | `[]` | no |
| <a name="input_test_condition_var_one"></a> [test\_condition\_var\_one](#input\_test\_condition\_var\_one) | The first condition variable | `string` | n/a | yes |
| <a name="input_test_condition_var_three"></a> [test\_condition\_var\_three](#input\_test\_condition\_var\_three) | The third condition variable | `string` | n/a | yes |
| <a name="input_test_condition_var_two"></a> [test\_condition\_var\_two](#input\_test\_condition\_var\_two) | The second condition variable | `string` | n/a | yes |
| <a name="input_tf_role"></a> [tf\_role](#input\_tf\_role) | The name of the role allowed to access secrets | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_kms_key_alias"></a> [kms\_key\_alias](#output\_kms\_key\_alias) | n/a |
| <a name="output_kms_key_id"></a> [kms\_key\_id](#output\_kms\_key\_id) | n/a |
