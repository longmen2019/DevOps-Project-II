

data "azurerm_client_config" "current" {}

# resource "azurerm_resource_group" "rg" {
#   name     = var.resource_group_name
#   location = var.location 
# }

resource "azurerm_key_vault" "kv-lm" {
  name                        = var.keyvault_name
  location                    = var.location 
  resource_group_name         = var.resource_group_name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false
  enable_rbac_authorization   = true 
  sku_name                    = "premium"


}




