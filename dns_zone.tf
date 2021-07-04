resource "azurerm_private_dns_zone" "dns" {
  name                = var.private_dns_zone_name
  resource_group_name = azurerm_resource_group.poc-vnet.name
}

resource "azurerm_private_dns_zone_virtual_network_link" "link" {
  name                  = "poc-link"
  resource_group_name   = azurerm_resource_group.poc-vnet.name
  private_dns_zone_name = azurerm_private_dns_zone.dns.name
  virtual_network_id    = azurerm_virtual_network.hub.id
  registration_enabled  = true
}

resource "azurerm_private_dns_zone_virtual_network_link" "spoke-link" {
  name                  = "spoke-link"
  resource_group_name   = azurerm_resource_group.poc-vnet.name
  private_dns_zone_name = azurerm_private_dns_zone.dns.name
  virtual_network_id    = azurerm_virtual_network.spoke.id
  registration_enabled  = true
}
