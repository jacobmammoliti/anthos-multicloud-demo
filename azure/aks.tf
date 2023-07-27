resource "azurerm_kubernetes_cluster" "non_prod_management_cluster" {
  name                = "np-mgmt-cluster-azure"
  location            = azurerm_resource_group.non_prod_rg.location
  resource_group_name = azurerm_resource_group.non_prod_rg.name

  dns_prefix = "npmgmtcluster"

  workload_identity_enabled = true
  oidc_issuer_enabled       = true

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = var.aks_settings["node_size"]
  }

  identity {
    type = "SystemAssigned"
  }

  tags = var.tags
}

resource "azurerm_kubernetes_cluster_node_pool" "non_prod_management_cluster_node_pool" {
  name                  = "npmgmtpool01"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.non_prod_management_cluster.id
  vm_size               = var.aks_settings["node_size"]
  node_count            = var.aks_settings["node_pool_size"]
  tags                  = var.tags
}