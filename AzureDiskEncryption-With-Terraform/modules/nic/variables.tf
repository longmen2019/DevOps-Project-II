variable "resource_group_name_prefix" {
  type        = string
  default     = "rg"
  description = "Prefix of the resource group name that's combined with a random ID so name is unique in your Azure subscription."
}

variable "location" {
  description = "Azure region where the NIC will be deployed"
  type        = string
}

variable "resource-group-name" {
  description = "Name of the resource group for the NIC"
  type        = string
}

variable "enable_accelerated_networking" {
  description = "Enable accelerated networking on the NIC"
  type        = bool
  default     = false
}

variable "ip-address" {
  description = "Optional static private IP address for the NIC. If null, dynamic allocation is used."
  type        = string
  default     = null
}

variable "subnet-id" {
  description = "ID of the subnet to associate with the NIC"
  type        = string
}

variable "global-tags" {
  description = "Tags to apply to the NIC resource"
  type        = map(string)
  default     = {}
}
