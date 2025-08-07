# # backend-resources.tf

# # resource "azurerm_resource_group" "tf_state" {
# #   name     = "tf-state-rg"
# #   location = "North Europe"
# # }

# # resource "azurerm_storage_account" "tf_state" {
# #   name                     = "tfstate12345678" # Use a globally unique name
# #   resource_group_name      = azurerm_resource_group.tf_state.name
# #   location                 = azurerm_resource_group.tf_state.location
# #   account_tier             = "Standard"
# #   account_replication_type = "LRS"
# # }

# # resource "azurerm_storage_container" "tf_state" {
# #   name                  = "tfstate"
# #   storage_account_name  = azurerm_storage_account.tf_state.name
# #   container_access_type = "private"
# # }


# resource "azurerm_resource_group" "main" {
#   name     = "${var.resource_group_name}-${var.environment}"
#   location = var.location
# }
# resource "azurerm_storage_account" "stacc-lm" {
#   name                     = "tfstate12345678" # Use a globally unique name
#   resource_group_name      =  azurerm_resource_group.main.name 
#   location                 = var.location 
#   account_tier             = "Standard"
#   account_replication_type = "LRS"

#   tags = {
#     environment = "staging"
#   }
# }

# resource "azurerm_storage_container" "example" {
#   name                  = "vhds-lm"
#   storage_account_id    = azurerm_storage_account.stacc-lm.id
#   container_access_type = "private"
# }