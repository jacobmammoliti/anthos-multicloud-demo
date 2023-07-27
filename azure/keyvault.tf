resource "random_pet" "non_prod_key_vault_name" {
  length = 3
}

resource "azurerm_key_vault" "non_prod_key_vault" {
  name                        = random_pet.non_prod_key_vault_name.id
  tenant_id                   = var.tenant_id
  location                    = azurerm_resource_group.non_prod_rg.location
  resource_group_name         = azurerm_resource_group.non_prod_rg.name
  enabled_for_disk_encryption = true
  sku_name                    = "premium"
  enable_rbac_authorization   = true
}