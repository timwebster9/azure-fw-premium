resource "azurerm_network_interface" "example" {
  name                = "example-nic"
  location            = azurerm_resource_group.poc-vnet.location
  resource_group_name = azurerm_resource_group.poc-vnet.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.spoke.id
    private_ip_address_allocation = "Static"
    private_ip_address            = var.spoke_vm_ip_address
  }
}

resource "azurerm_linux_virtual_machine" "example" {
  name                = "spoke-vm"
  resource_group_name = azurerm_resource_group.poc-vnet.name
  location            = azurerm_resource_group.poc-vnet.location
  size                = var.spoke_vm_size
  disable_password_authentication = false
  admin_username      = var.spoke_vm_admin_username
  admin_password      = var.spoke_vm_admin_password

  # deploy after firewall rules are in place so cloud-init works
  depends_on = [
    azurerm_firewall.fw-poc,
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