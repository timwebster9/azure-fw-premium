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
      destination_fqdns = ["*.ubuntu.com"]
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
      source_addresses  = var.cidr_hub_subnet_appgw
      destination_fqdns = ["127.0.0.1"]
    }

  }

  # network_rule_collection {
  #   name     = "hub_to_spoke"
  #   priority = 400
  #   action   = "Allow"
  #   rule {
  #     name                  = "allow-bastion-ssh"
  #     protocols             = ["TCP"]
  #     source_addresses      = var.cidr_hub_subnet_default
  #     destination_addresses = var.cidr_spoke_vnet
  #     destination_ports     = ["22"]
  #   }
  #}

  # nat_rule_collection {
  #   name     = "nat_rule_collection1"
  #   priority = 300
  #   action   = "Dnat"
  #   rule {
  #     name                = "nat_rule_collection1_rule1"
  #     protocols           = ["TCP", "UDP"]
  #     source_addresses    = ["10.0.0.1", "10.0.0.2"]
  #     destination_address = "192.168.1.1"
  #     destination_ports   = ["80", "1000-2000"]
  #     translated_address  = "192.168.0.1"
  #     translated_port     = "8080"
  #   }
  # }
}