output "aks_connection_string" {
  value = format("az aks get-credentials --resource-group ${azurerm_resource_group.non_prod_rg.name} --name ${azurerm_kubernetes_cluster.non_prod_management_cluster.name}")
}