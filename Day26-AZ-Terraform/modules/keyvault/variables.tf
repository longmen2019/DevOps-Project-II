
variable "resource_group_name" {
    type = string 
    default = "demo-rg-lm"
  
}

variable "resource_group_location" {
    type = string 
    default = "eastus"
  
}
variable "service_principal_object_id" {
  
}
variable "service_principal_tenant_id" {
  
  
}

variable "location" {
    type = string 
    default = "eastus"
  
}

variable "service_principal_name" {
    type = string
    default = "demo-svcprincipallm"
  
}

variable "keyvault_name" {
  type = string 
  default = "keyvault-demolmvalue"
}

# variable "SUB_ID" {
#     type = string
  
# }
