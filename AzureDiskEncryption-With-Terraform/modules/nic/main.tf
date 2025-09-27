resource "random_pet" "rg_name" {
  prefix = var.resource_group_name_prefix
}

resource "azurerm_network_interface" "nic" {
  name                = random_pet.rg_name.id
  location            = var.location
  resource_group_name = var.resource-group-name

  accelerated_networking_enabled = var.enable_accelerated_networking

  dynamic "ip_configuration" {
    for_each = var.ip-address == null ? [] : [var.ip-address]

    content {
      name                          = "internal"
      subnet_id                     = var.subnet-id
      private_ip_address_allocation = "Static"
      private_ip_address            = ip_configuration.value
    }
  }

  dynamic "ip_configuration" {
    for_each = var.ip-address == null ? [1] : []

    content {
      name                          = "internal"
      subnet_id                     = var.subnet-id
      private_ip_address_allocation = "Dynamic"
    }
  }

  tags = var.global-tags
}