data "azurerm_client_config" "current" {}

data "azurerm_subscription" "current" {}

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

resource "azurerm_key_vault" "postgresql-secret" {
  count                       = var.store_password_to_secret_manager ? 1 : 0
  name                        = format("%s-%s-%s", var.environment, var.name, "psql")
  resource_group_name         = var.resource_group_name
  location                    = var.resource_group_location
  sku_name                    = "standard"
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  enabled_for_disk_encryption = true
  soft_delete_retention_days  = 7

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id
    key_permissions = [
      "Get",
      "List",
    ]
    secret_permissions = [
      "Set",
      "Get",
      "List",
      "Delete",
      "Purge",
    ]
  }
}

resource "azurerm_key_vault_secret" "postgresql-secret" {
  count      = var.store_password_to_secret_manager ? 1 : 0
  depends_on = [azurerm_key_vault.postgresql-secret[0]]
  name       = format("%s-%s-%s", var.environment, var.name, "secret")
  value = var.custom_credentials_enabled ? jsonencode(
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
  content_type = "application/json"
  key_vault_id = azurerm_key_vault.postgresql-secret[0].id
}