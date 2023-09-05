data "aws_caller_identity" "current" {}

data "aws_eks_cluster" "cluster" {
  name = var.cluster_name
}

data "aws_eks_cluster_auth" "cluster" {
  name = var.cluster_name
}

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

resource "aws_secretsmanager_secret" "postgresql_user_password" {
  count                   = var.store_password_to_secret_manager ? 1 : 0
  name                    = format("%s/%s/%s", var.environment, var.name, "postgresql")
  recovery_window_in_days = var.recovery_window_aws_secret
}

resource "aws_secretsmanager_secret_version" "postgresql_password" {
  count     = var.store_password_to_secret_manager ? 1 : 0
  secret_id = aws_secretsmanager_secret.postgresql_user_password[0].id
  secret_string = var.custom_credentials_enabled ? jsonencode(
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