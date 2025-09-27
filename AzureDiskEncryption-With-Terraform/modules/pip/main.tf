resource "azurerm_public_ip" "this" {
  count               = var.public_ip_config.enabled ? 1 : 0
  name                = local.public_ip.name
  resource_group_name = var.resource_group_name
  location            = var.virtual_machine_config.location
  allocation_method   = var.public_ip_config.allocation_method
  zones               = var.virtual_machine_config.zone != null ? [var.virtual_machine_config.zone] : null
  sku                 = var.public_ip_config.sku

  tags = var.tags
}