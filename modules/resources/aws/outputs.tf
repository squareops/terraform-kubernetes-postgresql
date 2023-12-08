output "postgresql_credential" {
  description = "PostgreSQL credentials used for accessing the database."
  value = {
    posgresql_username = "postgres",
    postgres_password  = var.custom_credentials_enabled ? var.custom_credentials_config.postgres_password : nonsensitive(random_password.postgresql_password[0].result),
    repmgr_username    = "repmgr",
    repmgr_password    = var.custom_credentials_enabled ? var.custom_credentials_config.repmgr_password : nonsensitive(random_password.repmgrPassword[0].result),
  }
}

output "iam_role_arn_backup" {
  value       = aws_iam_role.pgsql_backup_role.arn
  description = "IAM role arn for pgsql backup"
}

output "iam_role_arn_restore" {
  value       = aws_iam_role.pgsql_restore_role.arn
  description = "IAM role arn for pgsql restore"
}
