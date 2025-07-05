terraform{backend "azurerm" {
    resource_group_name  = "example-resources"
    storage_account_name = "lmen123xyz" # updated to match your existing storage account
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }}
