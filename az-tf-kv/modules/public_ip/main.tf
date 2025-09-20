resource "azurerm_public_ip" "pub_ip" {
  name                = "${var.prefix}-pip"
  resource_group_name = var.rg_name
  location            = var.rg_location
  allocation_method   = "Static"
}