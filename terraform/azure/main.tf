terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

# Azure Provider configuration
# Credentials are picked up automatically from CircleCI environment variables (ARM_CLIENT_ID, ARM_CLIENT_SECRET, etc.)
provider "azurerm" {
  features {}
}

# Resource: Resource Group
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.azure_location
}

# Resource: Storage Account
resource "azurerm_storage_account" "sa" {
  name                     = var.storage_account_name
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  is_hns_enabled           = true
  static_website {
    index_document = "index.html"
  }
}

# Output the website endpoint
output "primary_web_endpoint" {
  value       = azurerm_storage_account.sa.primary_web_endpoint
  description = "The primary web endpoint for the static website."
}