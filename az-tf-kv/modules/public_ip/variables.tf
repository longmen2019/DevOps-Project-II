variable "rg_name" {
  description = "The name of the Azure Resource Group"
  type        = string
}

variable "rg_location" {
  description = "The Azure region where the Resource Group will be created"
  type        = string
  default     = "East US" # Optional: set your preferred default region
}

variable "prefix" {
  description = "Prefix used for naming Azure resources"
  type        = string
}