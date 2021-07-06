resource "azurerm_resource_group_template_deployment" "firewall_policy" {
  name                = "fw-policy-deployment"
  resource_group_name = var.resource_group
  deployment_mode     = "Incremental"
  parameters_content = jsonencode({
    "name" = {
      value = var.name
    },
    "identityId" = {
      value = var.identity_id
    },
    "keyVaultName" = {
      value = var.keyvault_name
    },
    "certSecretId" = {
      value = var.cert_secret_id
    }
  })
  template_content = file("${path.module}/template.json")

  lifecycle {
    ignore_changes = [
      template_content,
    ]
  }
}