module "firewall_policy" {
  source = "./modules/firewall-policy"
  resource_group = azurerm_resource_group.poc-vnet.name
  name = var.hub_firewall_policy
  identity_id = azurerm_user_assigned_identity.fw-uami.id
  keyvault_name = azurerm_key_vault.example.name
  cert_secret_id = azurerm_key_vault_secret.azfw-cert.id

  depends_on = [
    azurerm_key_vault_access_policy.uami,
    azurerm_key_vault_secret.azfw-cert
  ]
}

module "firewall_rule_collection_group" {
  source = "./modules/firewall-rule-collection-group"
  resource_group = azurerm_resource_group.poc-vnet.name
  policy_name = var.hub_firewall_policy
  rule_group_name = "test-rule-collection-group"

  depends_on = [
    firewall_policy
  ]
}

resource "azurerm_public_ip" "pip-fw-poc" {
  name                = "pip-poc-fw"
  location            = azurerm_resource_group.poc-vnet.location
  resource_group_name = azurerm_resource_group.poc-vnet.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_firewall" "fw-poc" {
  name                = "fw-poc"
  location            = azurerm_resource_group.poc-vnet.location
  resource_group_name = azurerm_resource_group.poc-vnet.name
  sku_tier            = "Premium"
  firewall_policy_id  = module.firewall_policy.policy_id

  ip_configuration {
    name                 = "configuration"
    subnet_id            = azurerm_subnet.hub_firewall.id
    public_ip_address_id = azurerm_public_ip.pip-fw-poc.id
  }
}

resource "azurerm_monitor_diagnostic_setting" "fw-diags" {
  name               = "fw-diags"
  target_resource_id = azurerm_firewall.fw-poc.id
  log_analytics_workspace_id = azurerm_log_analytics_workspace.example.id

  log {
    category = "AzureFirewallApplicationRule"
    enabled  = true
    retention_policy {
      enabled = false
    }
  }

  log {
    category = "AzureFirewallNetworkRule"
    enabled  = true
    retention_policy {
      enabled = false
    }
  }

  log {
    category = "AzureFirewallDnsProxy"
    enabled  = false
    retention_policy {
      enabled = false
    }
  }

  metric {
    category = "AllMetrics"
    enabled = false

    retention_policy {
      days = 0
      enabled = false
    }
  }
}



