variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
  default = "three-tier-app-rg-prod"
}

variable "location" {
  description = "Azure region for resources"
  type        = string
  default = "northeurope"
}

variable "environment" {
    type = string
    default = "prod"
  
}


# variable "resource_name_prefix" {
#   description = "Prefix for resource names"
#   type        = string
# }

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default = {
    Environment = "Production"
    Project     = "Three-Tier-Application"
    ManagedBy   = "Terraform"
    Owner       = "DevOps Team"
  }
}

variable "sku" {
  description = "The SKU name of the container registry"
  type        = string
  default     = "Premium"
}

variable "georeplication_locations" {
  description = "List of Azure locations where the container registry should be geo-replicated"
  type        = list(string)
  default     = ["eastus", "canadacentral"]
}
