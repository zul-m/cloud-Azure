# Generate random resource group name
resource "random_pet" "rg_name" {
  prefix = var.resource_group_name_prefix
}

resource "azurerm_resource_group" "rg" {
  location = var.resource_group_location
  name     = "${random_pet.rg_name.id}-${var.env_name}"
}

resource "random_id" "log_analytics_workspace_name_suffix" {
  byte_length = 8
}

resource "azurerm_log_analytics_workspace" "insights" {
  location = var.log_analytics_workspace_location
  # The WorkSpace name has to be unique across the whole of azure;
  # not just the current subscription/tenant.
  name                = "${var.log_analytics_workspace_name}-${random_id.log_analytics_workspace_name_suffix.dec}"
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = var.log_analytics_workspace_sku
}

resource "azurerm_log_analytics_solution" "insights" {
  location              = azurerm_log_analytics_workspace.insights.location
  resource_group_name   = azurerm_resource_group.rg.name
  solution_name         = "ContainerInsights"
  workspace_name        = azurerm_log_analytics_workspace.insights.name
  workspace_resource_id = azurerm_log_analytics_workspace.insights.id

  plan {
    product   = "OMSGallery/ContainerInsights"
    publisher = "Microsoft"
  }
}

#aks
resource "azurerm_kubernetes_cluster" "cluster" {
  name = var.cluster_name
  #kubernetes_version  = data.azurerm_kubernetes_service_versions.current.latest_version
  location             = azurerm_resource_group.rg.location
  resource_group_name  = azurerm_resource_group.rg.name
  dns_prefix           = var.dns_prefix
  azure_policy_enabled = true
  # microsoft_defender {

  #   log_analytics_workspace_id = azurerm_log_analytics_workspace.insights.id

  # }

  oms_agent {
    log_analytics_workspace_id = azurerm_log_analytics_workspace.insights.id
  }
  tags = {
    Environment = var.env_name
  }

  default_node_pool {
    name       = "agentpool"
    node_count = var.agent_count
    vm_size    = "standard_d2_v2"
  }

  identity {
    type = "SystemAssigned"
  }


}