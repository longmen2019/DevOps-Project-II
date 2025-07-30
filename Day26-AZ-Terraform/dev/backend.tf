terraform {
  backend "azurerm" {
    resource_group_name  = "rg-demo-lm"
    storage_account_name = "backendsa101"
    container_name       = "tfstate"
    key                  = "prod.terraform.tfstate"
  }
}