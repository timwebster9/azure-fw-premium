# RG
resource "azurerm_resource_group" "poc-vnet" {
  name     = var.hub_resource_group
  location = var.location
}