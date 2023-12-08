# Postgresql DB
![squareops_avatar]

[squareops_avatar]: https://squareops.com/wp-content/uploads/2022/12/squareops-logo.png

### [SquareOps Technologies](https://squareops.com/) Your DevOps Partner for Accelerating cloud journey.
<br>
This module allows you to easily deploy a Postgresql database in HA on Kubernetes using Helm. It provides flexible configuration options for the Postgresql database, including storage class. Deploying Postgresql database exporters to gather metrics for Grafana. This module is designed to be highly configurable and customizable, and can be easily integrated into your existing Terraform infrastructure code.

## Supported Versions:

|  Postgrsql Helm Chart Version   |     K8s supported version (EKS, AKS & GKE)  |  
| :-----:                         |         :---                 |
| **11.7.9**                      |    **1.23,1.24,1.25,1.26,1.27**   |


## Usage Example

```hcl
locals {
  name        = "postgresql"
  region      = "us-east-2"
  environment = "prod"
  additional_tags = {
    Owner      = "organization_name"
    Expires    = "Never"
    Department = "Engineering"
  }
  store_password_to_secret_manager = true
  custom_credentials_enabled       = true
  custom_credentials_config = {
    postgres_password = "60rbJs901a6Oa9hzUM5x7s8Q"
    repmgr_password   = "IWHLlEYOt25jL4Io7pancB"
  }
}

module "aws" {
  source                           = "git@github.com:sq-ia/terraform-kubernetes-postgresql.git//modules/resourcces/aws"
  name                             = local.name
  environment                      = local.environment
  cluster_name                     = "cluster-name"
  store_password_to_secret_manager = local.store_password_to_secret_manager
  custom_credentials_enabled       = local.custom_credentials_enabled
  custom_credentials_config        = local.custom_credentials_config
}

module "postgresql" {
  source                      = "git@github.com:sq-ia/terraform-kubernetes-postgresql.git"
  postgresql_exporter_enabled = true
  postgresql_config = {
    name                             = local.name
    environment                      = local.environment
    replicaCount                     = 3
    storage_class                    = "gp2"
    postgresql_values                = ""
    store_password_to_secret_manager = local.store_password_to_secret_manager
    custom_credentials_enabled       = local.custom_credentials_enabled
    custom_credentials_config        = local.custom_credentials_config
    postgres_password                = local.custom_credentials_enabled ? "" : module.aws.postgresql_credential.postgres_password
    repmgr_password                  = local.custom_credentials_enabled ? "" : module.aws.postgresql_credential.repmgr_password
  }
}

```
- Refer [AWS examples](https://github.com/sq-ia/terraform-kubernetes-postgresql/tree/main/examples/complete/aws) for more details.
- Refer [Azure examples](https://github.com/sq-ia/terraform-kubernetes-postgresql/tree/main/examples/complete/azure) for more details.
- Refer [GCP examples](https://github.com/sq-ia/terraform-kubernetes-postgresql/tree/main/examples/complete/gcp) for more details.

## Important Notes
  1. In order to enable the exporter, it is required to deploy Prometheus/Grafana first.
  2. The exporter is a tool that extracts metrics data from an application or system and makes it available to be scraped by Prometheus.
  3. Prometheus is a monitoring system that collects metrics data from various sources, including exporters, and stores it in a time-series database.
  4. Grafana is a data visualization and dashboard tool that works with Prometheus and other data sources to display the collected metrics in a user-friendly way.
  5. To deploy Prometheus/Grafana, please follow the installation instructions for each tool in their respective documentation.
  6. Once Prometheus and Grafana are deployed, the exporter can be configured to scrape metrics data from your application or system and send it to Prometheus.
  7. Finally, you can use Grafana to create custom dashboards and visualize the metrics data collected by Prometheus.
  8. This module is compatible with EKS, AKS & GKE which is great news for users deploying the module on an AWS, Azure & GCP cloud. Review the module's documentation, meet specific configuration requirements, and test thoroughly after deployment to ensure everything works as expected.
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.23 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | >= 2.6 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | >= 2.13 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_helm"></a> [helm](#provider\_helm) | >= 2.6 |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | >= 2.13 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [helm_release.postgres_exporter](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [helm_release.postgresql_backup](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [helm_release.postgresql_ha](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [helm_release.postgresql_restore](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [kubernetes_namespace.postgresql](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_chart_version"></a> [chart\_version](#input\_chart\_version) | Version of the Postgresql helm chart that will be deployed. | `string` | `"11.7.9"` | no |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | Name of eks cluster | `string` | `""` | no |
| <a name="input_create_namespace"></a> [create\_namespace](#input\_create\_namespace) | Whether or not to deploy postgresql | `bool` | `true` | no |
| <a name="input_custom_credentials_config"></a> [custom\_credentials\_config](#input\_custom\_credentials\_config) | Specify the configuration settings for Postgresql to pass custom credentials during creation. | `any` | <pre>{<br>  "postgres_password": "",<br>  "repmgr_password": ""<br>}</pre> | no |
| <a name="input_custom_credentials_enabled"></a> [custom\_credentials\_enabled](#input\_custom\_credentials\_enabled) | Specifies whether to enable custom credentials for PostgreSQL database. | `bool` | `false` | no |
| <a name="input_iam_role_arn_backup"></a> [iam\_role\_arn\_backup](#input\_iam\_role\_arn\_backup) | IAM role ARN for backup (AWS) | `string` | `""` | no |
| <a name="input_iam_role_arn_restore"></a> [iam\_role\_arn\_restore](#input\_iam\_role\_arn\_restore) | IAM role ARN for restore (AWS) | `string` | `""` | no |
| <a name="input_postgres_password"></a> [postgres\_password](#input\_postgres\_password) | PostgresQL password | `any` | `""` | no |
| <a name="input_postgresql_backup_config"></a> [postgresql\_backup\_config](#input\_postgresql\_backup\_config) | configuration options for Pgsql database backups. It includes properties such as the S3 bucket Name, the S3 bucket region, and the cron expression for full backups. | `any` | <pre>{<br>  "bucket_name": "",<br>  "cron_for_full_backup": "",<br>  "s3_bucket_region": ""<br>}</pre> | no |
| <a name="input_postgresql_backup_enabled"></a> [postgresql\_backup\_enabled](#input\_postgresql\_backup\_enabled) | Specifies whether to enable backups for Pgsql database. | `bool` | `false` | no |
| <a name="input_postgresql_config"></a> [postgresql\_config](#input\_postgresql\_config) | Configuration options for the postgresql such as number of replica,chart version, storage class and store password at secret manager. | `map(string)` | <pre>{<br>  "environment": "",<br>  "name": "",<br>  "postgresql_values": "",<br>  "replicaCount": 3,<br>  "storage_class": "gp2",<br>  "store_password_to_secret_manager": true<br>}</pre> | no |
| <a name="input_postgresql_enabled"></a> [postgresql\_enabled](#input\_postgresql\_enabled) | Whether or not to deploy postgresql | `bool` | `true` | no |
| <a name="input_postgresql_exporter_enabled"></a> [postgresql\_exporter\_enabled](#input\_postgresql\_exporter\_enabled) | Whether or not to deploy postgresql exporter | `bool` | `false` | no |
| <a name="input_postgresql_namespace"></a> [postgresql\_namespace](#input\_postgresql\_namespace) | Name of the Kubernetes namespace where the postgresql will be deployed. | `string` | `"postgresql"` | no |
| <a name="input_postgresql_restore_config"></a> [postgresql\_restore\_config](#input\_postgresql\_restore\_config) | Configuration options for restoring dump to the Postgresql database. | `any` | <pre>{<br>  "bucket_uri": "",<br>  "file_name": "",<br>  "s3_bucket_region": ""<br>}</pre> | no |
| <a name="input_postgresql_restore_enabled"></a> [postgresql\_restore\_enabled](#input\_postgresql\_restore\_enabled) | Specifies whether to enable restoring dump to the Postgresql database. | `bool` | `false` | no |
| <a name="input_recovery_window_aws_secret"></a> [recovery\_window\_aws\_secret](#input\_recovery\_window\_aws\_secret) | Number of days that AWS Secrets Manager will wait before deleting a secret. This value can be set to 0 to force immediate deletion, or to a value between 7 and 30 days to allow for recovery. | `number` | `0` | no |
| <a name="input_repmgr_password"></a> [repmgr\_password](#input\_repmgr\_password) | Replication manager password | `any` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_postgresql_credential"></a> [postgresql\_credential](#output\_postgresql\_credential) | PostgreSQL credentials used for accessing the database. |
| <a name="output_postgresql_endpoints"></a> [postgresql\_endpoints](#output\_postgresql\_endpoints) | PostgreSQL endpoints in the Kubernetes cluster. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Contribution & Issue Reporting

To report an issue with a project:

  1. Check the repository's [issue tracker](https://github.com/sq-ia/terraform-kubernetes-postgresql.git/issues) on GitHub
  2. Search to see if the issue has already been reported
  3. If you can't find an answer to your question in the documentation or issue tracker, you can ask a question by creating a new issue. Be sure to provide enough context and details so others can understand your problem.

## License

Apache License, Version 2.0, January 2004 (http://www.apache.org/licenses/).

## Support Us

To support a GitHub project by liking it, you can follow these steps:

  1. Visit the repository: Navigate to the [GitHub repository](https://github.com/sq-ia/terraform-kubernetes-postgresql.git).

  2. Click the "Star" button: On the repository page, you'll see a "Star" button in the upper right corner. Clicking on it will star the repository, indicating your support for the project.

  3. Optionally, you can also leave a comment on the repository or open an issue to give feedback or suggest changes.

Starring a repository on GitHub is a simple way to show your support and appreciation for the project. It also helps to increase the visibility of the project and make it more discoverable to others.

## Who we are

We believe that the key to success in the digital age is the ability to deliver value quickly and reliably. That’s why we offer a comprehensive range of DevOps & Cloud services designed to help your organization optimize its systems & Processes for speed and agility.

  1. We are an AWS Advanced consulting partner which reflects our deep expertise in AWS Cloud and helping 100+ clients over the last 5 years.
  2. Expertise in Kubernetes and overall container solution helps companies expedite their journey by 10X.
  3. Infrastructure Automation is a key component to the success of our Clients and our Expertise helps deliver the same in the shortest time.
  4. DevSecOps as a service to implement security within the overall DevOps process and helping companies deploy securely and at speed.
  5. Platform engineering which supports scalable,Cost efficient infrastructure that supports rapid development, testing, and deployment.
  6. 24*7 SRE service to help you Monitor the state of your infrastructure and eradicate any issue within the SLA.

We provide [support](https://squareops.com/contact-us/) on all of our projects, no matter how small or large they may be.

To find more information about our company, visit [squareops.com](https://squareops.com/), follow us on [Linkedin](https://www.linkedin.com/company/squareops-technologies-pvt-ltd/), or fill out a [job application](https://squareops.com/careers/). If you have any questions or would like assistance with your cloud strategy and implementation, please don't hesitate to [contact us](https://squareops.com/contact-us/).
