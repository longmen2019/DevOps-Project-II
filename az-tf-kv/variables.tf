#####################################
# COMMON RESOURCE VALUES
#####################################
variable "rg_name" {
  description = "The name of the Azure Resource Group"
  type        = string
}

#####################################
# VIRTUAL NETWORK
#####################################
variable "rg_location" {
  description = "The Azure region where the Resource Group will be created"
  type        = string
  default     = "East US" # Optional: set your preferred default region
}

variable "vnet_name" {
  description = "The name of the Azure Virtual Network"
  type        = string
}

#####################################
# SUBNET
#####################################
variable "snet_name" {
  description = "The name of the subnet within the Virtual Network"
  type        = string
}

variable "prefix" {
  description = "Prefix used for naming Azure resources"
  type        = string
}

#####################################
# NETWORK INTERFACE
#####################################
variable "nic_name" {
  description = "The name of the Azure Network Interface"
  type        = string
}

#####################################
# VIRTUAL MACHINE 
#####################################
variable "vm_size" {
  description = "The size of the Azure Virtual Machine"
  type        = string
  default     = "Standard_DS1_v2" # Optional default
}

variable "publisher" {
  description = "Publisher of the VM image"
  type        = string
}

variable "offer" {
  description = "Offer of the VM image"
  type        = string
}

variable "sku" {
  description = "SKU of the VM image"
  type        = string
}

variable "admin_username" {
  type        = string
  description = "Admin username for the VM"
}

variable "admin_password" {
  type        = string
  description = "Admin password (optional if using SSH)"
  sensitive   = true
}

variable "ssh_public_key" {
  type        = string
  description = "SSH public key for VM access"
}
#####################################
# KEY VAULT
#####################################
variable "kv_name" {
  description = "The name of the Azure Key Vault"
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

#####################################
# KEY VAULT SECRET
#####################################
variable "kv_secret_name" {
  description = "The name of the Key Vault secret"
  type        = string
}

variable "kv_secret_value" {
  description = "The value to store in the Key Vault secret"
  type        = string
  sensitive   = true
}
