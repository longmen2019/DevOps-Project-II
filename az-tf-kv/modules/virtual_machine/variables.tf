variable "prefix" {
  description = "Prefix used for naming the virtual machine"
  type        = string
}

variable "rg_name" {
  description = "The name of the Azure Resource Group"
  type        = string
}

variable "nic_id" {
  description = "The ID of the Network Interface to attach to the Virtual Machine"
  type        = list(string)
}

variable "rg_location" {
  description = "Azure region where the virtual machine will be deployed"
  type        = string
}

variable "vm_size" {
  description = "The size of the Azure Virtual Machine"
  type        = string  
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


