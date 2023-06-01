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

  subscription_id = "ea17f9bb-2449-44e4-b111-d65ab460d3e0"
  tenant_id       = "91700184-c314-4dc9-bb7e-a411df456a1e"

}

resource "azurerm_resource_group" "rg" {
  name     = "demo-rg"
  location = "australiacentral"
}
