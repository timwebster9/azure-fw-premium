hub_resource_group = "rg-fwprem-15"
location = "uksouth"

# other stuff
me_object_id = "f82bf2b5-4249-47b9-ab5c-5ed57bfcf267"

# hub
hub_firewall_policy = "hub-default-policy"
cidr_hub_vnet = ["10.124.4.0/22"]
cidr_hub_subnet_azfw = ["10.124.4.0/26"]
cidr_hub_subnet_gw = ["10.124.4.64/27"]
cidr_hub_subnet_bastion = ["10.124.4.96/27"]
cidr_hub_subnet_default = ["10.124.6.0/24"]
cidr_hub_subnet_appgw = "10.124.7.0/24"
private_dns_zone_name = "uksouth.cloudapp.azure.com"

# app gateway (HUB)
appgw_private_ip = "10.124.7.4"
appgw_pip_name = "appgw-pip"
appgw_name     = "fw-poc-appgw"
appgw_ip_config_name = "fw-poc-appgw-ipconfig"
appgw_frontend_port_name = "frontend-port"
appgw_backend_pool_name = "backend-pool"
appgw_backend_http_settings_name = "http-settings"
appgw_backend_https_settings_name = "https-settings"
appgw_http_listener_name = "http-listener"
appgw_routing_rule_name = "routing-rule"
appgw_http_probe_name = "http-probe"
appgw_keepheader_http_probe_name = "keepheader-http-probe"
appgw_keepheader_https_probe_name = "keepheader-https-probe"
appgw_fwpoc_ssl_cert_name = "fwpoc-cert"

# spoke
cidr_spoke_vnet = ["10.124.14.0/23"]
cidr_spoke_subnet_default = ["10.124.14.0/28"]
cidr_spoke_subnet_appgw = "10.124.15.0/24"
spoke_vm_name = "fwpoctimw"
spoke_vm_size = "Standard_B1ms"
spoke_vm_ip_address = "10.124.14.4"
spoke_vm_admin_username = "adminuser"
spoke_vm_admin_password = "Passw0rd1234"

# app gateway (SPOKE)
appgw_spoke_private_ip = "10.124.15.4"
appgw_spoke_pip_name = "appgw-spoke-pip"
appgw_spoke_name     = "fw-poc-appgw-spoke"
appgw_spoke_ip_config_name = "fw-poc-appgw-spoke-ipconfig"
appgw_spoke_frontend_port_name = "frontend-port"
appgw_spoke_backend_pool_name = "backend-pool"
appgw_spoke_backend_http_settings_name = "http-settings"
appgw_spoke_backend_https_settings_name = "https-settings"
appgw_spoke_http_listener_name = "http-listener"
appgw_spoke_routing_rule_name = "routing-rule"
appgw_spoke_http_probe_name = "http-probe"
appgw_spoke_keepheader_http_probe_name = "keepheader-http-probe"
appgw_spoke_keepheader_https_probe_name = "keepheader-https-probe"
appgw_spoke_fwpoc_ssl_cert_name = "fwpoc-cert"