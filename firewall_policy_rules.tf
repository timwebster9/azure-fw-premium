resource "azurerm_firewall_policy_rule_collection_group" "example" {
  name               = "poc-rule-collection"
  firewall_policy_id = module.firewall_policy.policy_id
  priority           = 500

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
      destination_fqdns = [azurerm_public_ip.appgw_pip.ip_address, var.spoke_vm_ip_address, azurerm_public_ip.appgw_pip.fqdn]
    }

  }
}