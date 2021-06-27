resource "azurerm_public_ip" "bastion_pip" {
  name                = "bastion-pip"
  location            = azurerm_resource_group.poc-vnet.location
  resource_group_name = azurerm_resource_group.poc-vnet.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_bastion_host" "example" {
  name                = "poc-bastion"
  location            = azurerm_resource_group.poc-vnet.location
  resource_group_name = azurerm_resource_group.poc-vnet.name

  ip_configuration {
    name                 = "configuration"
    subnet_id            = azurerm_subnet.bastion.id
    public_ip_address_id = azurerm_public_ip.bastion_pip.id
  }
}