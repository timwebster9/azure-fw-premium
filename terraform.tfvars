hub_resource_group = "rg-fwprem-9"
location = "uksouth"

# hub
hub_firewall_policy = "hub-default-policy"
cidr_hub_vnet = ["10.124.4.0/22"]
cidr_hub_subnet_azfw = ["10.124.4.0/26"]
cidr_hub_subnet_gw = ["10.124.4.64/27"]
cidr_hub_subnet_bastion = ["10.124.4.96/27"]
cidr_hub_subnet_default = ["10.124.6.0/24"]
cidr_hub_subnet_appgw = "10.124.7.0/24"

# app gateway
appgw_private_ip = "10.124.7.4"
appgw_pip_name = "appgw-pip"
appgw_name     = "fw-poc-appgw"
appgw_ip_config_name = "fw-poc-appgw-ipconfig"
appgw_frontend_port_name = "frontend-port"
appgw_backend_pool_name = "backend-pool"
appgw_backend_http_settings_name = "http-settings"
appgw_http_listener_name = "http-listener"
appgw_routing_rule_name = "routing-rule"
appgw_http_probe_name = "http-probe"

# spoke
cidr_spoke_vnet = ["10.124.14.0/23"]
cidr_spoke_subnet_default = ["10.124.14.0/28"]
spoke_vm_size = "Standard_B1ms"
spoke_vm_ip_address = "10.124.14.4"
spoke_vm_admin_username = "adminuser"
spoke_vm_admin_password = "Passw0rd1234"
spoke_vm_fqdn = "spoke-vm.deggymacets.com"