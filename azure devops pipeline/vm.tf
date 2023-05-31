data "azurerm_key_vault" "kv-dev" {
  name                = "kv-agents-fr-01"
  resource_group_name = var.resource_group_name
}
data "azurerm_key_vault_secret" "pbk" {
  name         = "dev-publickey"
  key_vault_id = data.azurerm_key_vault.kv-dev.id
}

# Create virtual machine
resource "azurerm_linux_virtual_machine" "my_terraform_vm" {
  name                  = var.azurerm_linux_virtual_machine_name
  location              = var.resource_group_location
  resource_group_name   = var.resource_group_name
  network_interface_ids = [azurerm_network_interface.my_terraform_nic.id]
  size                  = var.azurerm_linux_virtual_machine_size

  os_disk {
    name                 = "myOsDisk"
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }

  source_image_reference {
    publisher = var.azurerm_linux_virtual_machine_publisher
    offer     = var.azurerm_linux_virtual_machine_offer
    sku       = var.azurerm_linux_virtual_machine_sku
    version   = "latest"
  }

  computer_name                   = var.computer_name
  admin_username                  = var.admin_username_vm
  disable_password_authentication = true

  admin_ssh_key {
    username   = var.admin_username_vm
    public_key = data.azurerm_key_vault_secret.pbk.value
  }

  boot_diagnostics {
    storage_account_uri = azurerm_storage_account.my_storage_account.primary_blob_endpoint
  }

  depends_on = [
    azurerm_storage_account.my_storage_account, azurerm_network_interface.my_terraform_nic
  ]

}