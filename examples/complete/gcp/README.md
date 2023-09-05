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

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_gcp"></a> [gcp](#module\_gcp) | git@github.com:sq-ia/terraform-kubernetes-postgresql.git//modules/resources/gcp | n/a |
| <a name="module_postgresql"></a> [postgresql](#module\_postgresql) | git@github.com:sq-ia/terraform-kubernetes-postgresql.git | n/a |

## Resources

| Name | Type |
|------|------|
| [google_client_config.default](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/client_config) | data source |
| [google_container_cluster.primary](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/container_cluster) | data source |

## Inputs

No inputs.

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_posgresql_credential"></a> [posgresql\_credential](#output\_posgresql\_credential) | PostgreSQL credentials used for accessing the database. |
| <a name="output_posgresql_endpoints"></a> [posgresql\_endpoints](#output\_posgresql\_endpoints) | PostgreSQL endpoints in the Kubernetes cluster. |
<!-- END_TF_DOCS -->
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_gcp"></a> [gcp](#module\_gcp) | git@github.com:sq-ia/terraform-kubernetes-postgresql.git//modules/resources/gcp | n/a |
| <a name="module_postgresql"></a> [postgresql](#module\_postgresql) | git@github.com:sq-ia/terraform-kubernetes-postgresql.git | n/a |

## Resources

| Name | Type |
|------|------|
| [google_client_config.default](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/client_config) | data source |
| [google_container_cluster.primary](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/container_cluster) | data source |

## Inputs

No inputs.

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_posgresql_credential"></a> [posgresql\_credential](#output\_posgresql\_credential) | PostgreSQL credentials used for accessing the database. |
| <a name="output_posgresql_endpoints"></a> [posgresql\_endpoints](#output\_posgresql\_endpoints) | PostgreSQL endpoints in the Kubernetes cluster. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
