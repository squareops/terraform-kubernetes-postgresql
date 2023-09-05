resource "random_password" "postgresql_password" {
  count   = var.custom_credentials_enabled ? 0 : 1
  length  = 20
  special = false
}

resource "random_password" "repmgrPassword" {
  count   = var.custom_credentials_enabled ? 0 : 1
  length  = 20
  special = false
}


resource "google_secret_manager_secret" "postgresql-secret" {
  count     = var.store_password_to_secret_manager ? 1 : 0
  project   = var.project_id
  secret_id = format("%s-%s-%s", var.environment, var.name, "psql")

  replication {
    automatic = true
  }
}

resource "google_secret_manager_secret_version" "postgresql-secret" {
  count  = var.store_password_to_secret_manager ? 1 : 0
  secret = google_secret_manager_secret.postgresql-secret[0].id
  secret_data = var.custom_credentials_enabled ? jsonencode(
    {
      "posgresql_username" : "postgres",
      "postgres_password" : "${var.custom_credentials_config.postgres_password}",
      "repmgr_username" : "repmgr",
      "repmgr_password" : "${var.custom_credentials_config.repmgr_password}"
    }) : jsonencode(
    {
      "posgresql_username" : "postgres",
      "postgres_password" : "${random_password.postgresql_password[0].result}",
      "repmgr_username" : "repmgr",
      "repmgr_password" : "${random_password.repmgrPassword[0].result}"
  })
}