variable "kv_name" {
  description = "The name of the Azure Key Vault"
  type        = string
}

variable "rg_location" {
  description = "The Azure region where the Key Vault will be created"
  type        = string
}

variable "rg_name" {
  description = "The name of the Resource Group for the Key Vault"
  type        = string
}

variable "key_permissions" {
  description = "List of key permissions for the Key Vault access policy"
  type        = list(string)

}

variable "secret_permissions" {
  description = "List of secret permissions for the Key Vault access policy"
  type        = list(string)
  
}

variable "storage_permissions" {
  description = "List of storage permissions for the Key Vault access policy"
  type        = list(string)
}

variable "vm_principal_id" {
  description = "The object ID of the VM's system-assigned managed identity"
  type        = string
}

