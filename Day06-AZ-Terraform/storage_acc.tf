# 👇 Reference existing storage account instead of creating a new one
data "azurerm_storage_account" "existing" {
  name                = "lmen123xyz"
  resource_group_name = data.azurerm_resource_group.example.name
}

output "resource_group_name" {
  value = data.azurerm_resource_group.example.name
}