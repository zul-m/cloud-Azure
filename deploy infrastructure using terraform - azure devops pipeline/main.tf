provider "azurerm" {
    # The "feature" block is required for AzureRM provider 2.x.
    # If you're using version 1.x, the "features" block is not allowed.
    version = "~>2.0"
    features {}
}

terraform {
  backend "azurerm" {}
}
data "azurerm_client_config" "current" {}

# Create a new resource groupe called : hellodemo-01
resource "azurerm_resource_group" "tfrg" {
  name     = "hellodemo-01"
  location = "australiacentral"
}

# In the previous group now we are going to create a storage account named demostorage01
resource "azurerm_storage_account" "tfstorage" {
  name                     = "demostorage01"
  resource_group_name      = azurerm_resource_group.tfrg.name
  location                 = azurerm_resource_group.tfrg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}