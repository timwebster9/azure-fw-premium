resource "azurerm_public_ip" "vm-pip" {
    name                         = "vm-pip"
    location                     = azurerm_resource_group.poc-vnet.location
    resource_group_name          = azurerm_resource_group.poc-vnet.name
    allocation_method            = "Static"
}

resource "azurerm_network_interface" "example" {
  name                = "example-nic"
  location            = azurerm_resource_group.poc-vnet.location
  resource_group_name = azurerm_resource_group.poc-vnet.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.spoke.id
    private_ip_address_allocation = "Static"
    private_ip_address            = var.spoke_vm_ip_address
    public_ip_address_id          = azurerm_public_ip.vm-pip.id
  }
}

resource "azurerm_linux_virtual_machine" "example" {
  name                = "spoke-vm"
  resource_group_name = azurerm_resource_group.poc-vnet.name
  location            = azurerm_resource_group.poc-vnet.location
  size                = "Standard_B2ms"
  disable_password_authentication = false
  admin_username      = "adminuser"
  admin_password      = "Passw0rd1234"

  depends_on = [
    azurerm_firewall_policy_rule_collection_group.example
  ]

  network_interface_ids = [
    azurerm_network_interface.example.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }

  custom_data = filebase64("customdata.yaml")

}