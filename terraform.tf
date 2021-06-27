terraform {
  required_providers {
    azure = {
      source = "azuread"
      version = "1.5.1"
    }
    azurerm = {
      source = "azurerm"
      version = "2.64.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "cloud-shell-storage-westeurope"
    storage_account_name = "csb2ca654743b7bx40f2xb24"
    container_name       = "tfstate"
    key                  = "rlgpoc.tfstate"
  }
}