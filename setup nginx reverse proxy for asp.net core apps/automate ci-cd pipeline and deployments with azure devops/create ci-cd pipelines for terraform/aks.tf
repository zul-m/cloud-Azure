resource "azurerm_kubernetes_cluster" "cluster01" {
  name = var.cluster_name
  #kubernetes_version  = data.azurerm_kubernetes_service_versions.current.latest_version
  location             = var.resource_group_location
  resource_group_name  = var.rg_name
  dns_prefix           = var.dns_prefix
  azure_policy_enabled = true
  oms_agent {
    log_analytics_workspace_id = azurerm_log_analytics_workspace.insights.id
  }
  tags = {
    Environment = var.env_name
  }
  default_node_pool {
    name       = var.agentpool_name
    node_count = var.agent_count
    vm_size    = var.vm_size
  }
  identity {
    type = var.identity
  }
}