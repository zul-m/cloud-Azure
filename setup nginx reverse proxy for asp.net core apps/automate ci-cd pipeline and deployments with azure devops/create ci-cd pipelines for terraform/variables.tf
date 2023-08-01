variable "cluster_name" {
  description = "The name for the AKS cluster"
  default     = "mumuaks"
}
variable "env_name" {
  description = "The environment for the AKS cluster"
  default     = "dev"
}

variable "resource_group_name_prefix" {
  default     = "rg"
  description = "Prefix of the resource group name that's combined with a random ID so name is unique in your Azure subscription."
}

variable "resource_group_location" {
  default     = "australiacentral"
  description = "Location of the resource group."
}

# Refer to https://azure.microsoft.com/pricing/details/monitor/ for Log Analytics pricing
variable "log_analytics_workspace_sku" {
  default = "PerGB2018"
}

variable "log_analytics_workspace_name" {
  default = "log-dvs-aks-dev-fc-01"
}

# Refer to https://azure.microsoft.com/global-infrastructure/services/?products=monitor for available Log Analytics regions.
variable "log_analytics_workspace_location" {
  default = "australiacentral"
}
variable "dns_prefix" {
  default = "hostnametest"
}

variable "rg_name" {
  default = "azure-loves-terraform-2023"
}

variable "agentpool_name" {
  default = "agentpool01"
}

variable "vm_size" {
  default = "standard_b2s"
}

variable "identity" {
  default = "SystemAssigned"
}

variable "agent_count" {
  default = 1
}

variable "container_registry_name" {
  default = "crdvsaksdevfc01"
}

variable "container_registry_sku" {
  default = "Standard"
}

variable "aks_role_assignment" {
  default = "AcrPull"
}