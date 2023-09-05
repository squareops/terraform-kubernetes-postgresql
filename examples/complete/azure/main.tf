locals {
  name        = "postgresql"
  region      = "eastus"
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

module "azure" {
  source                           = "git@github.com:sq-ia/terraform-kubernetes-postgresql.git//modules/resources/azure"
  name                             = local.name
  environment                      = local.environment
  resource_group_name              = ""
  resource_group_location          = local.region
  store_password_to_secret_manager = local.store_password_to_secret_manager
  custom_credentials_enabled       = local.custom_credentials_enabled
  custom_credentials_config        = local.custom_credentials_config
}

module "postgresql" {
  source                      = "git@github.com:sq-ia/terraform-kubernetes-postgresql.git"
  depends_on                  = [module.azure]
  postgresql_exporter_enabled = true
  postgresql_config = {
    name                             = local.name
    environment                      = local.environment
    replicaCount                     = 1
    storage_class                    = "infra-service-sc"
    postgresql_values                = file("./helm/postgresql.yaml")
    store_password_to_secret_manager = local.store_password_to_secret_manager
  }
  custom_credentials_enabled = local.custom_credentials_enabled
  custom_credentials_config  = local.custom_credentials_config
  postgres_password          = local.custom_credentials_enabled ? "" : module.azure.postgres_password
  repmgr_password            = local.custom_credentials_enabled ? "" : module.azure.repmgr_password
}
