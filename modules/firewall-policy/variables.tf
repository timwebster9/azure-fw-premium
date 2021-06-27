variable resource_group {
  type = string
  description = "Firewall policy resource group"
}

variable name {
  type = string
  description = "Firewall policy name"
}

variable identity_id {
  type = string
  description = "resource id of the UAMI used for retrieving certificates from Key Vault"
}

variable keyvault_name {
  type = string
  description = "Key vault name for firewall certificate"
}

variable cert_secret_id {
  type = string
  description = "ID of firewall certificate secret"
}