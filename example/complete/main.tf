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
  cluster_name                = ""
  create_namespace            = true
  postgresql_namespace        = "postgressql"
  postgresql_exporter_enabled = true
  postgresql_config = {
    name                             = local.name
    environment                      = local.environment
    replicaCount                     = 1
    storage_class                    = "gp2"
    postgresql_values                = file("./helm/postgresql.yaml")
    database_name                    = "postgress_custom"
    store_password_to_secret_manager = local.store_password_to_secret_manager
  }
  custom_credentials_enabled = true
  custom_credentials_config = {
    postgres_password = "60rbJs901a6Oa9hzUM5x7s8Q"
    repmgr_password   = "IWHLlEYOt25jL4Io7pancB"
  }
}
