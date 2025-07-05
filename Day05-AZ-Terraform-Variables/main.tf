terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "example-resources"
    storage_account_name = "lmen123xyz" # updated to match your existing storage account
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
  required_version = ">=1.9.0"
}

provider "azurerm" {
  features {}
}

variable "environment" {
  type        = string
  description = "The environment type"
  default     = "staging"
}

locals {
  common_tags = {
    environment = "dev"
    lob         = "banking"
    stage       = "alpha"
  }
}

# 👇 Reference existing resource group instead of creating a new one
data "azurerm_resource_group" "example" {
  name = "example-resources"
}

# 👇 Reference existing storage account instead of creating a new one
data "azurerm_storage_account" "existing" {
  name                = "lmen123xyz"
  resource_group_name = data.azurerm_resource_group.example.name
}

output "resource_group_name" {
  value = data.azurerm_resource_group.example.name
}

output "storage_account_id" {
  value = data.azurerm_storage_account.existing.id
}
