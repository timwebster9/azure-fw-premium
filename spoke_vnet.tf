# SPOKE VNET
resource "azurerm_virtual_network" "spoke" {
  name                = "vnet-poc-spoke"
  location            = azurerm_resource_group.poc-vnet.location
  resource_group_name = azurerm_resource_group.poc-vnet.name
  address_space       = var.cidr_spoke_vnet
}

# SUBNETS
resource "azurerm_subnet" "spoke" {
  name                 = "spoke-sn"
  resource_group_name  = azurerm_resource_group.poc-vnet.name
  virtual_network_name = azurerm_virtual_network.spoke.name
  address_prefixes     = var.cidr_spoke_subnet_default
}

resource "azurerm_subnet" "spoke-appgw" {
  name                 = "appgw-sn"
  resource_group_name  = azurerm_resource_group.poc-vnet.name
  virtual_network_name = azurerm_virtual_network.spoke.name
  address_prefixes     = [var.cidr_spoke_subnet_appgw]
}

# ROUTES
resource "azurerm_route_table" "spoke_subnet" {
  name                          = "spoke-rt"
  location                      = azurerm_resource_group.poc-vnet.location
  resource_group_name           = azurerm_resource_group.poc-vnet.name
  disable_bgp_route_propagation = false

  route {
    name           = "default-to-firewall"
    address_prefix = "0.0.0.0/0"
    next_hop_type  = "VirtualAppliance"
    next_hop_in_ip_address = "10.124.4.4"
  }

  route {
    name           = "appgw-to-firewall"
    address_prefix = var.cidr_hub_subnet_appgw
    next_hop_type  = "VirtualAppliance"
    next_hop_in_ip_address = "10.124.4.4"
  }
}

resource "azurerm_subnet_route_table_association" "spoke-rt-association" {
  subnet_id      = azurerm_subnet.spoke.id
  route_table_id = azurerm_route_table.spoke_subnet.id
}