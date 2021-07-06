resource "azurerm_resource_group_template_deployment" "rule_collection_group" {
  name                = "rcg-deployment"
  resource_group_name = var.resource_group
  deployment_mode     = "Incremental"
  parameters_content = jsonencode({
    "policyName" = {
      value = var.policy_name
    },
    "ruleGroupName" = {
      value = var.rule_group_name
    }
  })
  template_content = file("${path.module}/template.json")

  lifecycle {
    ignore_changes = [
      template_content,
    ]
  }
}