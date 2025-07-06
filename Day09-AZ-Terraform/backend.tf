terraform {
   backend "azurerm" {
      resource_group_name  = "tfstate-day07"
      storage_account_name = "day0707052025"
      container_name       = "tfstate"
      key                  = "dev.terraform.tfstate"
  }
}