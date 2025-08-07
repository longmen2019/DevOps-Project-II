variable "resource_name_prefix" {
    description = "Prefix for resource names"
    type = string 
  
}

variable "location" {
    type = string 
  
}

variable "resource_group_name" {
  
}

variable "tenant_id" {
  description = "The Azure AD tenant ID"
  type        = string
}



variable "object_id" {
  description = "The object ID of the current user/service principal"
  type        = string
}


variable "tags" {
  description = "The Azure AD tenant ID"
  type = map(string )
}

variable "backend_identity_principal_id" {
  description = "Principal ID of the backend managed identity"
  type        = string
  default     = null
}