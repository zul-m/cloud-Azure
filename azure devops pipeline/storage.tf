# Create storage account for boot diagnostics
resource "azurerm_storage_account" "my_storage_account" {
  name                     = var.azurerm_storage_account_name
  location                 = var.resource_group_location
  resource_group_name      = var.resource_group_name
  account_tier             = var.azurerm_storage_account_account_tier
  account_replication_type = "GRS"
}