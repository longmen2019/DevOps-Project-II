variable "kv_secret_name" {
  description = "The name of the Key Vault secret"
  type        = string
}

variable "kv_secret_value" {
  description = "The value to store in the Key Vault secret"
  type        = string
  sensitive   = true
}

variable "key_vault_id" {
  description = "The ID of the Key Vault where the secret will be stored"
  type        = string
}
