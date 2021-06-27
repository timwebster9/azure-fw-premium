resource "azurerm_public_ip" "appgw_pip" {
  name                = var.appgw_pip_name
  resource_group_name = azurerm_resource_group.poc-vnet.name
  location            = azurerm_resource_group.poc-vnet.location
  sku                 = "Standard"
  allocation_method   = "Static"
}

resource "azurerm_application_gateway" "appgw" {
  name                = var.appgw_name
  resource_group_name = azurerm_resource_group.poc-vnet.name
  location            = azurerm_resource_group.poc-vnet.location

  sku {
    name     = "Standard_v2"
    tier     = "Standard_v2"
  }

  autoscale_configuration {
    min_capacity = 0
    max_capacity = 2
  }

  gateway_ip_configuration {
    name      = var.appgw_ip_config_name
    subnet_id = azurerm_subnet.hub_appgw.id
  }

  frontend_port {
    name = var.appgw_frontend_port_name
    port = 80
  }

  frontend_ip_configuration {
    name                 = var.appgw_ip_config_name
    public_ip_address_id = azurerm_public_ip.appgw_pip.id
  }

  backend_address_pool {
    name = var.appgw_backend_pool_name
    ip_addresses = tolist([var.spoke_vm_ip_address])
  }

  probe {
    host = "127.0.0.1"
    interval = 10
    name = var.appgw_http_probe_name
    protocol = "http"
    path = "/"
    timeout = 5
    unhealthy_threshold = 3
  }

  backend_http_settings {
    name                  = var.appgw_backend_http_settings_name
    cookie_based_affinity = "Disabled"
    path                  = "/"
    port                  = 80
    protocol              = "Http"
    request_timeout       = 60
    #probe_name            = var.appgw_http_probe_name
  }

  http_listener {
    name                           = var.appgw_http_listener_name
    frontend_ip_configuration_name = var.appgw_ip_config_name
    frontend_port_name             = var.appgw_frontend_port_name
    protocol                       = "Http"
  }

  request_routing_rule {
    name                       = var.appgw_routing_rule_name
    rule_type                  = "Basic"
    http_listener_name         = var.appgw_http_listener_name
    backend_address_pool_name  = var.appgw_backend_pool_name
    backend_http_settings_name = var.appgw_backend_http_settings_name
  }
}