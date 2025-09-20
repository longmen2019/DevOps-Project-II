output "kv_secret_id" {
  description = "The ID of the Key Vault secret"
  value       = azurerm_key_vault_secret.kv_secret.id
}

output "kv_secret_name" {
  description = "The name of the Key Vault secret"
  value       = azurerm_key_vault_secret.kv_secret.name
}

output "kv_secret_version" {
  description = "The version of the Key Vault secret"
  value       = azurerm_key_vault_secret.kv_secret.version
}
