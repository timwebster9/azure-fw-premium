# VNET
resource "azurerm_virtual_network" "hub" {
  name                = "vnet-poc-hub"
  location            = azurerm_resource_group.poc-vnet.location
  resource_group_name = azurerm_resource_group.poc-vnet.name
  address_space       = var.cidr_hub_vnet
}

# SUBNETS
resource "azurerm_subnet" "hub_firewall" {
  name                 = "AzureFirewallSubnet"
  resource_group_name  = azurerm_resource_group.poc-vnet.name
  virtual_network_name = azurerm_virtual_network.hub.name
  address_prefixes     = var.cidr_hub_subnet_azfw
}

resource "azurerm_subnet" "hub_gateway" {
  name                 = "GatewaySubnet"
  resource_group_name  = azurerm_resource_group.poc-vnet.name
  virtual_network_name = azurerm_virtual_network.hub.name
  address_prefixes     = var.cidr_hub_subnet_gw
}

resource "azurerm_subnet" "hub_appgw" {
  name                 = "appgw"
  resource_group_name  = azurerm_resource_group.poc-vnet.name
  virtual_network_name = azurerm_virtual_network.hub.name
  address_prefixes     = [var.cidr_hub_subnet_appgw]
}

resource "azurerm_subnet" "hub_default" {
  name                 = "default"
  resource_group_name  = azurerm_resource_group.poc-vnet.name
  virtual_network_name = azurerm_virtual_network.hub.name
  address_prefixes     = var.cidr_hub_subnet_default
}

resource "azurerm_subnet" "bastion" {
  name                 = "AzureBastionSubnet"
  resource_group_name  = azurerm_resource_group.poc-vnet.name
  virtual_network_name = azurerm_virtual_network.hub.name
  address_prefixes     = var.cidr_hub_subnet_bastion
}

resource "azurerm_route_table" "hub_to_spoke" {
  name                          = "hub-rt"
  location                      = azurerm_resource_group.poc-vnet.location
  resource_group_name           = azurerm_resource_group.poc-vnet.name
  disable_bgp_route_propagation = false

  route {
    name           = "hub-to-spoke-via-fw"
    address_prefix = "10.124.14.0/23"
    next_hop_type  = "VirtualAppliance"
    next_hop_in_ip_address = "10.124.4.4"
  }
}

resource "azurerm_subnet_route_table_association" "appgw-subnet-hub-to-spoke" {
  subnet_id      = azurerm_subnet.hub_appgw.id
  route_table_id = azurerm_route_table.hub_to_spoke.id
}

# not supported
# resource "azurerm_subnet_route_table_association" "bastion-subnet-hub-to-spoke" {
#   subnet_id      = azurerm_subnet.bastion.id
#   route_table_id = azurerm_route_table.hub_to_spoke.id
# }