variable "aks_settings" {
  type = map(any)
  default = {
    "node_size"      = "Standard_DS2_v2"
    "node_pool_size" = 3
    "disk_size_gb"   = 50
    "aks_version"    = "1.27.1"
  }
  description = "(optional) Map of AKS cluster settings."
}

variable "location" {
  type        = string
  default     = "East US"
  description = "(optional) Default Azure location to deploy to."
}

variable "subscription_id" {
  type        = string
  description = "(required) Subscription ID to use for Azure Service Operator."
}

variable "tags" {
  type = map(string)
  default = {
    "Environment" = "Non-Production"
  }
  description = "(optional) Map of tags to assign to infrastructure deployed."
}

variable "tenant_id" {
  type        = string
  description = "(required) Tenant ID to use for Azure Key Vault."
}
