# 👇 Reference existing resource group instead of creating a new one
data "azurerm_resource_group" "example" {
  name = "example-resources"
}