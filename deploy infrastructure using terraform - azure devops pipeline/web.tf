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

resource "azurerm_app_service_plan" "tfplan" {
  name                = "tfplanwebapp"
  location            = azurerm_resource_group.tfrg.location
  resource_group_name = azurerm_resource_group.tfrg.name

  sku {
    tier = "Standard"
    size = "S1"
  }
}

resource "azurerm_app_service" "tfapp" {
  name                = "tfwebapp"
  location            = azurerm_resource_group.tfrg.location
  resource_group_name = azurerm_resource_group.tfrg.name
  app_service_plan_id = azurerm_app_service_plan.tfplan.id

  site_config {
    dotnet_framework_version = "v4.0"
    scm_type                 = "LocalGit"
  }
}