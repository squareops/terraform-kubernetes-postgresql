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
}

module "postgresql" {
  source                      = "git@github.com:sq-ia/terraform-kubernetes-postgresql.git"
  cluster_name                = "cluster-name"
  postgresql_exporter_enabled = true
  postgresql_config = {
    name                             = local.name
    environment                      = local.environment
    replicaCount                     = 3
    storage_class                    = "gp2"
    postgresql_values                = file("./helm/postgresql.yaml")
    store_password_to_secret_manager = local.store_password_to_secret_manager
  }
  postgresql_custom_credentials_enabled = true
  postgresql_custom_credentials_config = {
    postgres_password = "60rbJs901a6Oa9hzUM5x7s8Q"
    repmgr_password   = "IWHLlEYOt25jL4Io7pancB"
  }
}
