# We strongly recommend using the required_providers block to set the
# Azure Provider source and version being used
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
  }
#   backend "azurerm" {
#       resource_group_name  = "tfstate"
#       storage_account_name = "36sdfd7sdf"
#       container_name       = "tfstate"
#       key                  = "terraform.tfstate"
#   }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
#   resource_provider_registrations = "none" # This is only required when the User, Service Principal, or Identity running Terraform lacks the permissions to register Azure Resource Providers.
  features {}
}
resource "azurerm_resource_group" "state-demo-secure" {
  name     = "state-demo"
  location = "eastus"
}

resource "azurerm_resource_group" "example" {
  name     = "MyResourceGroup"
  location = "West Europe"
}

resource "azurerm_storage_account" "example" {
  name                     = "storageaccountname"
  resource_group_name      = azurerm_resource_group.state-demo-secure.name
  location                 = azurerm_resource_group.state-demo-secure.location
  account_tier             = "Standard"
  account_replication_type = "GRS"

  tags = {
    environment = "staging"
  }
}