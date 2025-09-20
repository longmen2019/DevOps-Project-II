variable "nic_name" {
  description = "The name of the Azure Network Interface"
  type        = string
}

variable "rg_location" {
  description = "The Azure region where the Network Interface will be created"
  type        = string
}

variable "rg_name" {
  description = "The name of the Resource Group for the Network Interface"
  type        = string
}

variable "subnet_id" {
  description = "The ID of the subnet to associate with the Network Interface"
  type        = string
}

variable "public_id" {
  description = "The ID of the public IP to associate with the Network Interface"
  type        = string
}
