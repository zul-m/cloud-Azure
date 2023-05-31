# Create public IP for our vm
resource "azurerm_public_ip" "my_terraform_public_ip" {
  name                = var.ip_name
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  allocation_method   = var.ip_allocation_method
}