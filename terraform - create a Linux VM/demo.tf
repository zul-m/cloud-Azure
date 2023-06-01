terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
  }
}

provider "azurerm" {
  # The "feature" block is required for AzureRM provider 2.x.
  # If you are using version 1.x, the "features" block is not allowed.
  features {}

  subscription_id = "YOUR_SUBSCRIPTION_ID"
  tenant_id       = "YOUR_TENANT_ID"

}

resource "azurerm_resource_group" "rg" {
  name     = "demo-rg"
  location = "australiacentral"
}
