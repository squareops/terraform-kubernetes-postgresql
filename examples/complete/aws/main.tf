locals {
  name        = "postgresql"
  region      = "us-east-2"
  environment = "prodd"
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
  source                           = "git@github.com:sq-ia/terraform-kubernetes-postgresql.git//modules/resources/aws"
  name                             = local.name
  environment                      = local.environment
  cluster_name                     = ""
  store_password_to_secret_manager = local.store_password_to_secret_manager
  custom_credentials_enabled       = local.custom_credentials_enabled
  custom_credentials_config        = local.custom_credentials_config
}

module "postgresql" {
  source                      = "git@github.com:sq-ia/terraform-kubernetes-postgresql.git"
  postgresql_exporter_enabled = true
  custom_credentials_enabled  = local.custom_credentials_enabled
  custom_credentials_config   = local.custom_credentials_config
  repmgr_password             = module.aws.postgresql_credential.repmgr_password
  postgres_password           = module.aws.postgresql_credential.postgres_password
  postgresql_config = {
    name                             = local.name
    environment                      = local.environment
    replicaCount                     = 3
    storage_class                    = "gp2"
    postgresql_values                = file("./helm/postgresql.yaml")
    store_password_to_secret_manager = local.store_password_to_secret_manager
  }
  iam_role_arn_backup       = module.aws.iam_role_arn_backup
  postgresql_backup_enabled = true
  postgresql_backup_config = {
    bucket_name          = "backup-309017165673"
    s3_bucket_region     = "us-east-2"
    cron_for_full_backup = "*/5 * * * *"
  }
  postgresql_restore_enabled = true
  iam_role_arn_restore       = module.aws.iam_role_arn_restore
  postgresql_restore_config = {
    bucket_uri       = "s3://backup-309017165673/pgdump__20231208095502.zip"
    file_name        = "pgdump__20231208095502.zip"
    s3_bucket_region = "us-east-2"
  }
}
