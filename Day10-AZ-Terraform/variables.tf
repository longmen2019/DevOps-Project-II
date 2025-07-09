variable "environment" {
    type = string
    default = "dev"
    description = "Environment name (e.g., dev, prod, staging)"
  
}


variable "storage_account_name" {
    type = list(string)
    description = "List of allowed Azure storage accounts"
    default = [ "techtutorials11", "techtutorials12", "techtutorials13" ]
  
}