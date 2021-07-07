resource "azurerm_firewall_policy_rule_collection_group" "example" {
  name               = "poc-rule-collection"
  firewall_policy_id = module.firewall_policy.policy_id
  priority           = 500

  nat_rule_collection {
    name     = "nat_rule_collection"
    priority = 300
    action   = "Dnat"
    rule {
      name                = "nat_rule_collection1_rule1"
      protocols           = ["TCP"]
      source_addresses    = ["*"]
      destination_address = azurerm_public_ip.pip-fw-poc.ip_address
      destination_ports   = "443"
      translated_address  = var.appgw_spoke_private_ip
      translated_port     = "443"
    }
  }

  application_rule_collection {
    name     = "infra-rules"
    priority = 500
    action   = "Allow"

    rule {
      name = "ubuntu-rules"
      protocols {
        type = "Http"
        port = 80
      }
      protocols {
        type = "Https"
        port = 443
      }
      source_addresses  = var.cidr_spoke_vnet
      destination_fqdns = ["*.ubuntu.com", "*.snapcraft.io", "*.letsencrypt.org"]
    }

    rule {
      name = "appgw-probe"
      protocols {
        type = "Http"
        port = 80
      }
      protocols {
        type = "Https"
        port = 443
      }
      source_addresses  = [var.cidr_hub_subnet_appgw]
      destination_fqdns = [azurerm_public_ip.pip-fw-poc.ip_address, var.spoke_vm_ip_address, azurerm_public_ip.pip-fw-poc.fqdn]
    }

  }
}