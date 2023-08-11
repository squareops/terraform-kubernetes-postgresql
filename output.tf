output "posgresql_endpoints" {
  description = "PostgreSQL endpoints in the Kubernetes cluster."
  value = {
    postgresql_port               = "5432",
    postgresql_ha_pgpool_endpoint = "postgresql-ha-pgpool.${var.postgresql_namespace}.svc.cluster.local",
    postgresql_primary_endpoint   = "postgresql-ha-postgresql.${var.postgresql_namespace}.svc.cluster.local",
    postgresql_headless_endpoint  = "postgresql-ha-postgresql-headlesss.${var.postgresql_namespace}.svc.cluster.local",
    postgresql_metrics_endpoint   = "postgresql-ha-postgresql-metrics.${var.postgresql_namespace}.svc.cluster.local"
  }
}

output "posgresql_credential" {
  description = "PostgreSQL credentials used for accessing the database."
  value = var.postgresql_config.store_password_to_secret_manager ? null : {
    posgresql_username = "postgres",
    postgres_password  = var.postgresql_custom_credentials_enabled ? var.postgresql_custom_credentials_config.postgres_password : nonsensitive(random_password.postgresql_password[0].result),
    repmgr_username    = "repmgr",
    repmgr_password    = var.postgresql_custom_credentials_enabled ? var.postgresql_custom_credentials_config.repmgr_password : nonsensitive(random_password.repmgrPassword[0].result),
  }
}
