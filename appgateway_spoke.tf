# resource "azurerm_public_ip" "appgw_spoke_pip" {
#   name                = var.appgw_spoke_pip_name
#   resource_group_name = azurerm_resource_group.poc-vnet.name
#   location            = azurerm_resource_group.poc-vnet.location
#   sku                 = "Standard"
#   allocation_method   = "Static"
#   domain_name_label   = "fwpocspokepip"
# }

# resource "azurerm_application_gateway" "appgw_spoke" {
#   name                = var.appgw_spoke_name
#   resource_group_name = azurerm_resource_group.poc-vnet.name
#   location            = azurerm_resource_group.poc-vnet.location

#   sku {
#     name     = "WAF_v2"
#     tier     = "WAF_v2"
#   }

#   autoscale_configuration {
#     min_capacity = 0
#     max_capacity = 2
#   }

#   gateway_ip_configuration {
#     name      = var.appgw_spoke_ip_config_name
#     subnet_id = azurerm_subnet.spoke-appgw.id
#   }

#   frontend_port {
#     name = var.appgw_spoke_frontend_port_name
#     port = 443
#   }

#   # Public IP
#   frontend_ip_configuration {
#     name                          = var.appgw_spoke_ip_config_name
#     public_ip_address_id          = azurerm_public_ip.appgw_spoke_pip.id
#   }

#   # Private IP
#   frontend_ip_configuration {
#     name                          = var.appgw_spoke_private_ip_config_name
#     private_ip_address            = var.appgw_spoke_private_ip
#     private_ip_address_allocation = "Static"
#     subnet_id                     = azurerm_subnet.spoke-appgw.id
#   }

#   backend_address_pool {
#     name = var.appgw_spoke_backend_pool_name
#     fqdns = tolist([azurerm_public_ip.pip-fw-poc.fqdn])
#   }

#   # probe for use if original request hostname is OVERRIDDEN
#   probe {
#     pick_host_name_from_backend_http_settings = true
#     interval = 10
#     name = var.appgw_http_probe_name
#     protocol = "http"
#     path = "/"
#     timeout = 3
#     unhealthy_threshold = 3
#   }

#   # probe for use if original request hostname is KEPT
#   probe {
#     host = azurerm_public_ip.pip-fw-poc.fqdn
#     interval = 10
#     name = var.appgw_spoke_keepheader_http_probe_name
#     protocol = "http"
#     path = "/"
#     timeout = 3
#     unhealthy_threshold = 3
#   }

#   # HTTPS probe for use if original request hostname is KEPT
#   probe {
#     host = azurerm_public_ip.pip-fw-poc.fqdn
#     interval = 10
#     name = var.appgw_spoke_keepheader_https_probe_name
#     protocol = "https"
#     path = "/"
#     timeout = 3
#     unhealthy_threshold = 3
#   }

#   # HTTP backend
#   backend_http_settings {
#     #pick_host_name_from_backend_address = true
#     name                  = var.appgw_spoke_backend_http_settings_name
#     cookie_based_affinity = "Disabled"
#     port                  = 80
#     protocol              = "Http"
#     request_timeout       = 60
#     probe_name            = var.appgw_spoke_keepheader_http_probe_name
#   }

#   # HTTPS backend
#   backend_http_settings {
#     #pick_host_name_from_backend_address = true
#     name                  = var.appgw_spoke_backend_https_settings_name
#     cookie_based_affinity = "Disabled"
#     port                  = 443
#     protocol              = "Https"
#     request_timeout       = 60
#     probe_name            = var.appgw_spoke_keepheader_https_probe_name
#   }

#   identity {
#     identity_ids = [azurerm_user_assigned_identity.appgw-uami.id]
#   }

#   ssl_certificate {
#     name = var.appgw_spoke_fwpoc_ssl_cert_name
#     key_vault_secret_id = azurerm_key_vault_secret.appgw-cert.id
#   }

#   # Public IP listener
#   # http_listener {
#   #   name                           = var.appgw_spoke_http_listener_name
#   #   frontend_ip_configuration_name = var.appgw_spoke_ip_config_name
#   #   frontend_port_name             = var.appgw_spoke_frontend_port_name
#   #   protocol                       = "Https"
#   #   ssl_certificate_name           = var.appgw_spoke_fwpoc_ssl_cert_name
#   #   host_name                      = azurerm_public_ip.pip-fw-poc.fqdn
#   # }

#     # Private IP listener
#   http_listener {
#     name                           = var.appgw_spoke_private_http_listener_name
#     frontend_ip_configuration_name = var.appgw_spoke_private_ip_config_name
#     frontend_port_name             = var.appgw_spoke_frontend_port_name
#     protocol                       = "Https"
#     ssl_certificate_name           = var.appgw_spoke_fwpoc_ssl_cert_name
#     host_name                      = azurerm_public_ip.pip-fw-poc.fqdn
#   }

#   request_routing_rule {
#     name                       = var.appgw_spoke_routing_rule_name
#     rule_type                  = "Basic"
#     http_listener_name         = var.appgw_spoke_private_http_listener_name
#     backend_address_pool_name  = var.appgw_spoke_backend_pool_name
#     backend_http_settings_name = var.appgw_spoke_backend_http_settings_name
#   }

#   waf_configuration {
#     enabled           = true
#     firewall_mode     = "Prevention"
#     rule_set_type     = "OWASP"
#     rule_set_version  = "3.1"
#   }
# }

# resource "azurerm_monitor_diagnostic_setting" "appgw-spoke-diags" {
#   name               = "appgw-diags"
#   target_resource_id = azurerm_application_gateway.appgw_spoke.id
#   log_analytics_workspace_id = azurerm_log_analytics_workspace.example.id

#   log {
#     category = "ApplicationGatewayAccessLog"
#     enabled  = true
#     retention_policy {
#       enabled = false
#     }
#   }

#   log {
#     category = "ApplicationGatewayPerformanceLog"
#     enabled  = true
#     retention_policy {
#       enabled = false
#     }
#   }

#   log {
#     category = "ApplicationGatewayFirewallLog"
#     enabled  = true
#     retention_policy {
#       enabled = false
#     }
#   }

#   metric {
#     category = "AllMetrics"
#     enabled = false

#     retention_policy {
#       days = 0
#       enabled = false
#     }
#   }
# }