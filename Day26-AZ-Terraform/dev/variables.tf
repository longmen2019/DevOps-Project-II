variable "resource_group_name" {
    type = string
    description = "resource group name"
  
}

variable "location" {
    type = string
    default = "eastus"
  
}
variable "service_principal_name" {
    type = string
  
}

variable "keyvault_name" {
    type = string
  
}
variable "SUB_ID" {
    type = string
  
}

variable "node_pool_name" {
    type = string
    default = "demo-nodepool-lm"
  
}

variable "cluster_name" {
    type = string
    default = "demo-clustername-lm"
  
}
