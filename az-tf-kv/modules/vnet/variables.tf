variable "rg_name" {
  description = "The name of the Azure Resource Group"
  type        = string
}

variable "rg_location" {
  description = "The Azure region where the Resource Group will be created"
  type        = string  
}

variable "vnet_name" {
  description = "The name of the Azure Virtual Network"
  type        = string
}
