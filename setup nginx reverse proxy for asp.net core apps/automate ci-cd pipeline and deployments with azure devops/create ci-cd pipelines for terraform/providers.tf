terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.0.0"
    }
  }
  backend "azurerm" {
    use_msi = true
  }
}

provider "azurerm" {
  features {}
  skip_provider_registration = true
}