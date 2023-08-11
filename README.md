# Postgresql DB
![squareops_avatar]

[squareops_avatar]: https://squareops.com/wp-content/uploads/2022/12/squareops-logo.png

### [SquareOps Technologies](https://squareops.com/) Your DevOps Partner for Accelerating cloud journey.
<br>
This module allows you to easily deploy a Postgresql database in HA on Kubernetes using Helm. It provides flexible configuration options for the Postgresql database, including storage class. Deploying Postgresql database exporters to gather metrics for Grafana. This module is designed to be highly configurable and customizable, and can be easily integrated into your existing Terraform infrastructure code.

## Supported Versions:

|  Postgrsql Helm Chart Version   |     K8s supported version   |  
| :-----:                         |         :---                 |
| **11.7.9**                      |    **1.23,1.24,1.25,1.26**   |


## Usage Example

```hcl
module "postgresql" {
  source               = "git@github.com:sq-ia/terraform-kubernetes-postgresql.git"
  cluster_name         = "prod-cluster"
  postgresql_exporter_enabled = true
  postgresql_config = {
    name                             = "postgresql"
    environment                      = "prod"
    replicaCount                     = 3
    storage_class                    = "gp2"
    postgresql_values                = file("./helm/postgresql.yaml")
    store_password_to_secret_manager = true
  }
  postgresql_custom_credentials_enabled = true
  postgresql_custom_credentials_config = {
    postgres_password = "60rbJs901a6Oa9hzUM5x7s8Q"
    repmgr_password   = "IWHLlEYOt25jL4Io7pancB"
  }
}

```
Refer [examples](https://github.com/sq-ia/terraform-kubernetes-postgresql/tree/main/examples/complete) for more details.

## Important Notes
  1. In order to enable the exporter, it is required to deploy Prometheus/Grafana first.
  2. The exporter is a tool that extracts metrics data from an application or system and makes it available to be scraped by Prometheus.
  3. Prometheus is a monitoring system that collects metrics data from various sources, including exporters, and stores it in a time-series database.
  4. Grafana is a data visualization and dashboard tool that works with Prometheus and other data sources to display the collected metrics in a user-friendly way.
  5. To deploy Prometheus/Grafana, please follow the installation instructions for each tool in their respective documentation.
  6. Once Prometheus and Grafana are deployed, the exporter can be configured to scrape metrics data from your application or system and send it to Prometheus.
  7. Finally, you can use Grafana to create custom dashboards and visualize the metrics data collected by Prometheus.
  8. This module is compatible with EKS version 1.23,1.24,1.25 and 1.26, which is great news for users deploying the module on an EKS cluster running that version. Review the module's documentation, meet specific configuration requirements, and test thoroughly after deployment to ensure everything works as expected.
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
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.23 |
| <a name="provider_helm"></a> [helm](#provider\_helm) | >= 2.6 |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | >= 2.13 |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_secretsmanager_secret.postgresql_user_password](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret) | resource |
| [aws_secretsmanager_secret_version.postgresql_password](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret_version) | resource |
| [helm_release.postgres_exporter](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [helm_release.postgresql_ha](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [kubernetes_namespace.postgresql](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace) | resource |
| [random_password.postgresql_password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [random_password.repmgrPassword](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_eks_cluster.cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/eks_cluster) | data source |
| [aws_eks_cluster_auth.cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/eks_cluster_auth) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_chart_version"></a> [chart\_version](#input\_chart\_version) | Version of the Postgresql helm chart that will be deployed. | `string` | `"11.7.9"` | no |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | Name of eks cluster | `string` | `""` | no |
| <a name="input_postgresql_config"></a> [postgresql\_config](#input\_postgresql\_config) | Configuration options for the postgresql such as number of replica,chart version, storage class and store password at secret manager. | `map(string)` | <pre>{<br>  "environment": "",<br>  "name": "",<br>  "postgresql_values": "",<br>  "replicaCount": 3,<br>  "storage_class": "gp2",<br>  "store_password_to_secret_manager": true<br>}</pre> | no |
| <a name="input_postgresql_custom_credentials_config"></a> [postgresql\_custom\_credentials\_config](#input\_postgresql\_custom\_credentials\_config) | Specify the configuration settings for Postgresql to pass custom credentials during creation. | `any` | <pre>{<br>  "postgres_password": "",<br>  "repmgr_password": ""<br>}</pre> | no |
| <a name="input_postgresql_custom_credentials_enabled"></a> [postgresql\_custom\_credentials\_enabled](#input\_postgresql\_custom\_credentials\_enabled) | Specifies whether to enable custom credentials for PostgreSQL database. | `bool` | `false` | no |
| <a name="input_postgresql_enabled"></a> [postgresql\_enabled](#input\_postgresql\_enabled) | Whether or not to deploy postgresql | `bool` | `true` | no |
| <a name="input_postgresql_exporter_enabled"></a> [postgresql\_exporter\_enabled](#input\_postgresql\_exporter\_enabled) | Whether or not to deploy postgresql exporter | `bool` | `false` | no |
| <a name="input_postgresql_namespace"></a> [postgresql\_namespace](#input\_postgresql\_namespace) | Name of the Kubernetes namespace where the postgresql will be deployed. | `string` | `"postgresql"` | no |
| <a name="input_recovery_window_aws_secret"></a> [recovery\_window\_aws\_secret](#input\_recovery\_window\_aws\_secret) | Number of days that AWS Secrets Manager will wait before deleting a secret. This value can be set to 0 to force immediate deletion, or to a value between 7 and 30 days to allow for recovery. | `number` | `0` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_posgresql_credential"></a> [posgresql\_credential](#output\_posgresql\_credential) | PostgreSQL credentials used for accessing the database. |
| <a name="output_posgresql_endpoints"></a> [posgresql\_endpoints](#output\_posgresql\_endpoints) | PostgreSQL endpoints in the Kubernetes cluster. |
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
