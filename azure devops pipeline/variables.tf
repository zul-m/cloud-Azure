variable "resource_group_location" {
  type        = string
  default     = "francecentral"
  description = "Location of the resource group."
}

variable "resource_group_name" {
  default = "selfhostedagent-loves-terraform-2023"
}

variable "resource_group_name_prefix" {
  type        = string
  default     = "rg"
  description = "Prefix of the resource group name that's combined with a random ID so name is unique in your Azure subscription."
}

variable "ip_name" {
  type    = string
  default = "mypulicselfhostedip"
}

variable "ip_allocation_method" {
  type    = string
  default = "Dynamic"
}

variable "azurerm_network_security_group_name" {
  type    = string
  default = "nsg-selfhostedagent-fr"
}

variable "azurerm_storage_account_account_tier" {
  type    = string
  default = "Standard"
}

variable "azurerm_linux_virtual_machine_name" {
  type    = string
  default = "vmselfhosteddevopslinxufr"
}

variable "azurerm_linux_virtual_machine_size" {
  type    = string
  default = "Standard_DS1_v2"
}


variable "azurerm_linux_virtual_machine_publisher" {
  type    = string
  default = "Canonical"
}

variable "azurerm_linux_virtual_machine_offer" {
  type    = string
  default = "0001-com-ubuntu-server-jammy"
}

variable "azurerm_linux_virtual_machine_sku" {
  type    = string
  default = "22_04-lts-gen2"
}

variable "computer_name" {
  type    = string
  default = "agent001"
}

variable "admin_username_vm" {
  type    = string
  default = "agent001admin"
}



variable "azurerm_virtual_network_name" {
  type    = string
  default = "vnetvmd01evopsfr"
}

variable "azurerm_subnet_name" {
  type    = string
  default = "subnetvmdevopsfr"
}



variable "azurerm_network_interface_name" {
  type    = string
  default = "nicvmdevopsfr"
}

variable "nic_configuration" {
  type    = string
  default = "nic_configuration_vmdevopsfr"
}


variable "azurerm_storage_account_name" {
  type    = string
  default = "diagstvmdevopsfr"
}