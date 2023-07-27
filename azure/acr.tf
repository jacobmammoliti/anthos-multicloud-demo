resource "azurerm_container_registry" "non_prod_acr" {
  name                   = "nonProductionACR"
  location               = azurerm_resource_group.non_prod_rg.location
  resource_group_name    = azurerm_resource_group.non_prod_rg.name
  sku                    = "Premium"
  admin_enabled          = false
  anonymous_pull_enabled = true
}