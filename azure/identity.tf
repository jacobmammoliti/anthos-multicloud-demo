# Dedicated managed identity for Kaniko
resource "azurerm_user_assigned_identity" "kaniko_managed_identity" {
  name                = "kaniko-mi"
  location            = azurerm_resource_group.non_prod_rg.location
  resource_group_name = azurerm_resource_group.non_prod_rg.name
}

resource "azurerm_role_assignment" "assign_identity_acr_push" {
  scope                = azurerm_container_registry.non_prod_acr.id
  role_definition_name = "AcrPush"
  principal_id         = azurerm_user_assigned_identity.kaniko_managed_identity.principal_id
}

resource "azurerm_federated_identity_credential" "kaniko_federated_identity" {
  name                = "kaniko-federated-identity"
  resource_group_name = azurerm_resource_group.non_prod_rg.name
  audience            = ["api://AzureADTokenExchange"]
  issuer              = azurerm_kubernetes_cluster.non_prod_management_cluster.oidc_issuer_url
  parent_id           = azurerm_user_assigned_identity.kaniko_managed_identity.id
  subject             = "system:serviceaccount:argo-events:argo-events-sa"
}

# Dedicated managed identity for External Secrets Operator
resource "azurerm_user_assigned_identity" "eso_managed_identity" {
  name                = "eso-mi"
  location            = azurerm_resource_group.non_prod_rg.location
  resource_group_name = azurerm_resource_group.non_prod_rg.name
}

resource "azurerm_role_assignment" "assign_identity_kvsu_push" {
  scope                = azurerm_key_vault.non_prod_key_vault.id
  role_definition_name = "Key Vault Secrets User"
  principal_id         = azurerm_user_assigned_identity.eso_managed_identity.principal_id
}

resource "azurerm_federated_identity_credential" "eso_federated_identity" {
  name                = "eso-federated-identity"
  resource_group_name = azurerm_resource_group.non_prod_rg.name
  audience            = ["api://AzureADTokenExchange"]
  issuer              = azurerm_kubernetes_cluster.non_prod_management_cluster.oidc_issuer_url
  parent_id           = azurerm_user_assigned_identity.eso_managed_identity.id
  subject             = "system:serviceaccount:external-secrets:external-secrets-sa"
}

# Dedicated managed identity for Azure Service Operator
resource "azurerm_user_assigned_identity" "aso_managed_identity" {
  name                = "aso-mi"
  location            = azurerm_resource_group.non_prod_rg.location
  resource_group_name = azurerm_resource_group.non_prod_rg.name
}

resource "azurerm_role_assignment" "assign_identity_aso_contributer" {
  scope                = azurerm_resource_group.non_prod_rg.id
  role_definition_name = "Contributor"
  principal_id         = azurerm_user_assigned_identity.aso_managed_identity.principal_id
}

resource "azurerm_federated_identity_credential" "aso_federated_identity" {
  name                = "aso-federated-identity"
  resource_group_name = azurerm_resource_group.non_prod_rg.name
  audience            = ["api://AzureADTokenExchange"]
  issuer              = azurerm_kubernetes_cluster.non_prod_management_cluster.oidc_issuer_url
  parent_id           = azurerm_user_assigned_identity.aso_managed_identity.id
  subject             = "system:serviceaccount:azureserviceoperator-system:azureserviceoperator-default"
}