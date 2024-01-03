resource "random_password" "db_password" {
  length = 20
}

resource "azurerm_postgresql_flexible_server" "paperless_db" {
  name                  = "paperless-db"
  resource_group_name   = azurerm_resource_group.paperless.name
  location              = azurerm_resource_group.paperless.location
  version               = "15"
  sku_name              = "B_Standard_B1ms"
  storage_mb            = 32768
  backup_retention_days = 7

  administrator_login    = local.db_admin_name
  administrator_password = random_password.db_password.result

  authentication {
    password_auth_enabled = true
  }

}
