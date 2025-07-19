variable "location" {
    type = list(string)
    description = "value"
    default = ["eastus", "westus"]
  
}

variable "vm_sizes" {
    type = list(string)
    description = "value"
    default = [ "Standard_B2s","Standard_B2ms" ]
  
}

variable "allowed_tags" {
    type = list(string)
    description = "value"
    default = [ "department","project"]
  
}