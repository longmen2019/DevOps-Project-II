variable "environment" {
    type = string 
    description = "the env type"
    default = "staging"
  
}
variable "allowed_locations" {
    type = list(string)
    description = "list of allowed locations"
    default = [ "West Europe", "North Europe", "East US" ]
  
}

# Tuple type 
variable "network_config" {
    type = tuple([ string, string, number ])
    description = "Network configuration (VNET address, subnet address, subnet mask)"
    default = [ "10.0.0.0/16", "10.0.2.0", 24 ]
  
}

variable "allowed_vm_sizes" {
    type = list(string)
    description = "Allowed VM Sizes"
    default = ["Standard_DS1_v2", "Standard_DS2_v2", "Standard_DS3_v2"]

  
}