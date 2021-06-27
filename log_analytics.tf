resource "azurerm_log_analytics_workspace" "example" {
  name                = "poc-workspace"
  location            = azurerm_resource_group.poc-vnet.location
  resource_group_name = azurerm_resource_group.poc-vnet.name
  sku                 = "Free"
  retention_in_days   = 7
}