#resource "random_id" "log_analytics_workspace_name_suffix" {
#  byte_length = 8
#}

resource "azurerm_log_analytics_workspace" "insights" {
  location = var.resource_group_location
  # The WorkSpace name has to be unique across the whole of azure, not just the current subscription/tenant
  name                = var.log_analytics_workspace_name
  resource_group_name = var.rg_name
  sku                 = var.log_analytics_workspace_sku
}

resource "azurerm_log_analytics_solution" "insights" {
  location              = var.resource_group_location
  resource_group_name   = var.rg_name
  solution_name         = "ContainerInsights"
  workspace_name        = azurerm_log_analytics_workspace.insights.name
  workspace_resource_id = azurerm_log_analytics_workspace.insights.id
  plan {
    product   = "OMSGallery/ContainerInsights"
    publisher = "Microsoft"
  }
}