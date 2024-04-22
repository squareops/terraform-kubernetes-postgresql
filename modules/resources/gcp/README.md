## Postgresql Example
![squareops_avatar]

[squareops_avatar]: https://squareops.com/wp-content/uploads/2022/12/squareops-logo.png

### [SquareOps Technologies](https://squareops.com/) Your DevOps Partner for Accelerating cloud journey.
<br>
This example will be very useful for users who are new to a module and want to quickly learn how to use it. By reviewing the examples, users can gain a better understanding of how the module works, what features it supports, and how to customize it to their specific needs.

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | n/a |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_secret_manager_secret.postgresql-secret](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/secret_manager_secret) | resource |
| [google_secret_manager_secret_version.postgresql-secret](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/secret_manager_secret_version) | resource |
| [random_password.postgresql_password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [random_password.repmgrPassword](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_custom_credentials_config"></a> [custom\_credentials\_config](#input\_custom\_credentials\_config) | Custom credentials configuration. | `map` | <pre>{<br>  "postgres_password": "",<br>  "repmgr_password": ""<br>}</pre> | no |
| <a name="input_custom_credentials_enabled"></a> [custom\_credentials\_enabled](#input\_custom\_credentials\_enabled) | Set to true if you want to use custom credentials, false to generate random passwords. | `string` | `false` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | The name of the environment for resource naming. | `string` | `"dev"` | no |
| <a name="input_name"></a> [name](#input\_name) | A name or identifier for resources. | `string` | `""` | no |
| <a name="input_postgresql_config"></a> [postgresql\_config](#input\_postgresql\_config) | Configuration options for PostgreSQL. | `map` | <pre>{<br>  "store_password_to_secret_manager": false<br>}</pre> | no |
| <a name="input_recovery_window_aws_secret"></a> [recovery\_window\_aws\_secret](#input\_recovery\_window\_aws\_secret) | The recovery window (in days) for an AWS Secrets Manager secret. | `number` | `0` | no |
| <a name="input_store_password_to_secret_manager"></a> [store\_password\_to\_secret\_manager](#input\_store\_password\_to\_secret\_manager) | Store the password to sceret manager | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_postgres_password"></a> [postgres\_password](#output\_postgres\_password) | Postgresql password |
| <a name="output_postgresql_credential"></a> [postgresql\_credential](#output\_postgresql\_credential) | PostgreSQL credentials used for accessing the database. |
| <a name="output_repmgr_password"></a> [repmgr\_password](#output\_repmgr\_password) | Replication manager password |
<!-- END_TF_DOCS -->
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | n/a |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_secret_manager_secret.postgresql-secret](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/secret_manager_secret) | resource |
| [google_secret_manager_secret_version.postgresql-secret](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/secret_manager_secret_version) | resource |
| [random_password.postgresql_password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [random_password.repmgrPassword](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_custom_credentials_config"></a> [custom\_credentials\_config](#input\_custom\_credentials\_config) | Custom credentials configuration. | `map` | <pre>{<br>  "postgres_password": "",<br>  "repmgr_password": ""<br>}</pre> | no |
| <a name="input_custom_credentials_enabled"></a> [custom\_credentials\_enabled](#input\_custom\_credentials\_enabled) | Set to true if you want to use custom credentials, false to generate random passwords. | `string` | `false` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | The name of the environment for resource naming. | `string` | `"dev"` | no |
| <a name="input_name"></a> [name](#input\_name) | A name or identifier for resources. | `string` | `""` | no |
| <a name="input_postgresql_config"></a> [postgresql\_config](#input\_postgresql\_config) | Configuration options for PostgreSQL. | `map` | <pre>{<br>  "store_password_to_secret_manager": false<br>}</pre> | no |
| <a name="input_recovery_window_aws_secret"></a> [recovery\_window\_aws\_secret](#input\_recovery\_window\_aws\_secret) | The recovery window (in days) for an AWS Secrets Manager secret. | `number` | `0` | no |
| <a name="input_store_password_to_secret_manager"></a> [store\_password\_to\_secret\_manager](#input\_store\_password\_to\_secret\_manager) | Store the password to sceret manager | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_postgres_password"></a> [postgres\_password](#output\_postgres\_password) | Postgresql password |
| <a name="output_postgresql_credential"></a> [postgresql\_credential](#output\_postgresql\_credential) | PostgreSQL credentials used for accessing the database. |
| <a name="output_repmgr_password"></a> [repmgr\_password](#output\_repmgr\_password) | Replication manager password |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
