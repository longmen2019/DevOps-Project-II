data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "kv" {
  name                        = var.kv_name 
  location                    = var.rg_location
  resource_group_name         = var.rg_name 
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  purge_protection_enabled    = false

  sku_name = "standard"

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id
  
    key_permissions = var.key_permissions

    secret_permissions = var.secret_permissions

    storage_permissions = var.storage_permissions
  }
  access_policy {
  tenant_id = data.azurerm_client_config.current.tenant_id
  object_id = var.vm_principal_id

  secret_permissions = ["Get"]
}

}
