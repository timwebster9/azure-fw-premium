resource "azurerm_user_assigned_identity" "fw-uami" {
  resource_group_name = azurerm_resource_group.poc-vnet.name
  location            = azurerm_resource_group.poc-vnet.location

  name = "firewall-uami"
}

# resource "azurerm_role_assignment" "secrets_user" {
#   scope                = azurerm_key_vault.example.id
#   role_definition_name = "Key Vault Secrets User"
#   principal_id         = azurerm_user_assigned_identity.fw-uami.principal_id
# }

# resource "azurerm_role_assignment" "cert_officer" {
#   scope                = azurerm_key_vault.example.id
#   role_definition_name = "Key Vault Certificates Officer"
#   principal_id         = azurerm_user_assigned_identity.fw-uami.principal_id
# }