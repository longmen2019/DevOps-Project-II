output "key_vault_id" {
  description = "The ID of the Azure Key Vault"
  value       = azurerm_key_vault.kv.id
}

output "key_vault_name" {
  description = "The name of the Azure Key Vault"
  value       = azurerm_key_vault.kv.name
}

output "key_vault_uri" {
  description = "The URI of the Azure Key Vault"
  value       = azurerm_key_vault.kv.vault_uri
}

output "client_tenant_id" {
  description = "The tenant ID of the current Azure client"
  value       = data.azurerm_client_config.current.tenant_id
}

output "client_object_id" {
  description = "The object ID of the current Azure client"
  value       = data.azurerm_client_config.current.object_id
}
