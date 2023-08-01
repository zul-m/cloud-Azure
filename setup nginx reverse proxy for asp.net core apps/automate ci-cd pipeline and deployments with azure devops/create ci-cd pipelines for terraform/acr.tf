resource "azurerm_container_registry" "acr_01" {
  name                = var.container_registry_name
  resource_group_name = var.rg_name
  location            = var.resource_group_location
  sku                 = var.container_registry_sku
}

resource "azurerm_role_assignment" "roleforaks" {
  principal_id                     = azurerm_kubernetes_cluster.cluster01.kubelet_identity[0].object_id
  role_definition_name             = var.aks_role_assignment
  scope                            = azurerm_container_registry.acr_01.id
  skip_service_principal_aad_check = true
}