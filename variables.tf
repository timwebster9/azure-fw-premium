variable "location" {
  type = string
  description = "location"
}

variable "hub_resource_group" {
  type = string
  description = "Hub resource group name"
}

variable "app_domain_name_label" {
  type = string
  description = "DNS name for PIP"
}

variable "me_object_id" {
  type = string
  description = "user object id"
}

variable "hub_firewall_policy" {
  type = string
  description = "Hub firewall policy name"
}

variable "cidr_hub_vnet" {
  type = list(string)
  description = "hub vnet address space"
}

variable "cidr_hub_subnet_azfw" {
  type = list(string)
  description = "Hub Azure Firewall subnet CIDR"
}

variable "cidr_hub_subnet_gw" {
  type = list(string)
  description = "Hub VNet Gateway subnet CIDR"
}

variable "cidr_hub_subnet_bastion" {
  type = list(string)
  description = "Hub VNet bastion subnet CIDR"
}

variable "cidr_hub_subnet_default" {
  type = list(string)
  description = "Hub default subnet CIDR"
}

variable "private_dns_zone_name" {
  type = string
}

variable "cidr_hub_subnet_appgw" {
  type = string
  description = "Hub app gateway subnet CIDR"
}

## App Gateway (HUB)
variable "appgw_private_ip" {
  type = string
  description = "Hub app gateway private IP"
}

variable "appgw_pip_name" {
  type = string
}

variable "appgw_name" {
  type = string
}

variable "appgw_ip_config_name" {
  type = string
}

variable "appgw_frontend_port_name" {
  type = string
}

variable "appgw_backend_pool_name" {
  type = string
}

variable "appgw_backend_http_settings_name" {
  type = string
}
variable "appgw_backend_https_settings_name" {
  type = string
}

variable "appgw_http_listener_name" {
  type = string
}

variable "appgw_routing_rule_name" {
  type = string
}

variable "appgw_http_probe_name" {
  type = string
}

variable "appgw_keepheader_http_probe_name" {
  type = string
}

variable "appgw_keepheader_https_probe_name" {
  type = string
}

variable "appgw_fwpoc_ssl_cert_name" {
  type = string
}

## Spoke
variable "cidr_spoke_vnet" {
  type = list(string)
  description = "spoke vnet address space"
}

variable "cidr_spoke_subnet_default" {
  type = list(string)
  description = "Spoke default subnet CIDR"
}

variable "cidr_spoke_subnet_appgw" {
  type = string
  description = "Spoke App Gateway subnet CIDR"
}

variable "spoke_vm_name" {
  type = string
}

variable "spoke_vm_ip_address" {
  type = string
}

variable "spoke_vm_size" {
  type = string
}

variable "spoke_vm_admin_username" {
  type = string
}

variable "spoke_vm_admin_password" {
  type = string
}

## App Gateway (SPOKE)
variable "appgw_spoke_private_ip" {
  type = string
  description = "Spoke app gateway private IP"
}

variable "appgw_spoke_pip_name" {
  type = string
}

variable "appgw_spoke_name" {
  type = string
}

variable "appgw_spoke_ip_config_name" {
  type = string
}

variable "appgw_spoke_private_ip_config_name" {
  type = string
}

variable "appgw_spoke_frontend_port_name" {
  type = string
}

variable "appgw_spoke_backend_pool_name" {
  type = string
}

variable "appgw_spoke_backend_http_settings_name" {
  type = string
}
variable "appgw_spoke_backend_https_settings_name" {
  type = string
}

variable "appgw_spoke_http_listener_name" {
  type = string
}

variable "appgw_spoke_private_http_listener_name" {
  type = string
}

variable "appgw_spoke_routing_rule_name" {
  type = string
}

variable "appgw_spoke_http_probe_name" {
  type = string
}

variable "appgw_spoke_keepheader_http_probe_name" {
  type = string
}

variable "appgw_spoke_keepheader_https_probe_name" {
  type = string
}

variable "appgw_spoke_fwpoc_ssl_cert_name" {
  type = string
}
