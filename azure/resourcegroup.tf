resource "random_pet" "resource_group_name" {
  length = 3
}

resource "azurerm_resource_group" "non_prod_rg" {
  name     = random_pet.resource_group_name.id
  location = var.location
}