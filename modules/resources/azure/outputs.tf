output "postgresql_credential" {
  description = "PostgreSQL credentials used for accessing the database."
  value = var.postgresql_config.store_password_to_secret_manager ? null : {
    postgresql_username = "postgres",
    postgres_password   = var.custom_credentials_enabled ? var.custom_credentials_config.postgres_password : nonsensitive(random_password.postgresql_password[0].result),
    repmgr_username     = "repmgr",
    repmgr_password     = var.custom_credentials_enabled ? var.custom_credentials_config.repmgr_password : nonsensitive(random_password.repmgrPassword[0].result),
  }
}

output "postgres_password" {
  description = "Postgresql password"
  value       = var.custom_credentials_enabled ? var.custom_credentials_config.postgres_password : nonsensitive(random_password.postgresql_password[0].result)
}

output "repmgr_password" {
  description = "Replication manager password"
  value       = var.custom_credentials_enabled ? var.custom_credentials_config.repmgr_password : nonsensitive(random_password.repmgrPassword[0].result)
}
