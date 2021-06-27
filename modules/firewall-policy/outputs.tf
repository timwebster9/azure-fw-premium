output policy_id {
  value = jsondecode(azurerm_resource_group_template_deployment.firewall_policy.output_content).policyId.value
}