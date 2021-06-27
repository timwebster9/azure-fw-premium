resource "azurerm_key_vault" "example" {
  name                        = "poc-kv675674475675"
  location                    = azurerm_resource_group.poc-vnet.location
  resource_group_name         = azurerm_resource_group.poc-vnet.name
  enabled_for_disk_encryption = false
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false
  sku_name                    = "standard"
  //enable_rbac_authorization   = true
}

resource "azurerm_key_vault_access_policy" "uami" {
  key_vault_id = azurerm_key_vault.example.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = azurerm_user_assigned_identity.fw-uami.principal_id

  secret_permissions = [
    "Get", "List"
  ]
}

resource "azurerm_key_vault_access_policy" "me" {
  key_vault_id = azurerm_key_vault.example.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = data.azurerm_client_config.current.object_id

  secret_permissions = [
    "Get", "List", "Set", "Delete", "purge", "recover", "restore", "backup"
  ]
}

resource "azurerm_key_vault_secret" "azfw-cert" {
  name         = "azfw-imported-cert"
  key_vault_id = azurerm_key_vault.example.id
  depends_on = [
    azurerm_key_vault_access_policy.me
  ]

  value = filebase64("interCA.pfx")
}