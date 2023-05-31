# Create virtual network
resource "azurerm_virtual_network" "my_terraform_network" {
  name                = var.azurerm_virtual_network_name
  address_space       = ["10.0.0.0/16"]
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
}

# Create subnet
resource "azurerm_subnet" "my_terraform_subnet" {
  name                 = var.azurerm_subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.my_terraform_network.name
  address_prefixes     = ["10.0.1.0/24"]

  depends_on = [
    azurerm_virtual_network.my_terraform_network
  ]
}


# Create network interface
resource "azurerm_network_interface" "my_terraform_nic" {
  name                = var.azurerm_network_interface_name
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = var.nic_configuration
    subnet_id                     = azurerm_subnet.my_terraform_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.my_terraform_public_ip.id
  }

  depends_on = [
    azurerm_subnet.my_terraform_subnet, azurerm_public_ip.my_terraform_public_ip
  ]
}

# Connect the security group to the network interface
resource "azurerm_network_interface_security_group_association" "nsg_nic" {
  network_interface_id      = azurerm_network_interface.my_terraform_nic.id
  network_security_group_id = azurerm_network_security_group.my_terraform_nsg.id

  depends_on = [
    azurerm_network_interface.my_terraform_nic, azurerm_network_security_group.my_terraform_nsg
  ]
}