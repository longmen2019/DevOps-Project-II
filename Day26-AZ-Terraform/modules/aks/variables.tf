variable "location" {
    type = string
    # default = "eastus"
  
}

variable "cluster_name" {
    type = string
   
  
}

variable "resource_group_name" {
    type = string 
    
  
}

variable "client_id" {
       
  
}

variable "client_secret" {
  
}


variable "ssh_public_key" {
  default = "C:/Users/men_l/Downloads/DevOps-Project-II/day26-az-terraform/modules/aks/id_rsa.pub"
}

variable "node_pool_name" {
    type = string
    
  
}

variable "service_principal_name" {
  type = string
}
