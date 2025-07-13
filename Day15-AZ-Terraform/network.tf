resource "random_string" "suffix" {
  length  = 6
  special = false
  upper   = false
}


locals {
  spoke1-location       = "Central US"
  spoke1-resource-group = "spoke1-vnet-rg-${random_string.suffix.result}"
  prefix-spoke1         = "spoke1"
}

resource "azurerm_resource_group" "rg" {
  name     = local.spoke1-resource-group
  location = local.spoke1-location
}

resource "azurerm_virtual_network" "vnet1" {
  name                = "vnet1-${random_string.suffix.result}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = ["10.0.0.0/16"]
  # dns_servers         = ["10.0.0.4", "10.0.0.5"]

}

resource "azurerm_subnet" "sn1" {
  name                 = "sn1-${random_string.suffix.result}"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet1.name
  address_prefixes     = ["10.0.0.0/24"]

 
}

resource "azurerm_virtual_network" "vnet2" {
  name                = "vnet2-${random_string.suffix.result}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = ["10.1.0.0/16"]
  # dns_servers         = ["10.0.0.4", "10.0.0.5"]
}


resource "azurerm_subnet" "sn2" {
  name                 = "sn2-${random_string.suffix.result}"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet2.name
  address_prefixes     = ["10.1.0.64/27"]
}

resource "azurerm_virtual_network_peering" "example-1" {
  name                      = "peer1to2"
  resource_group_name       = azurerm_resource_group.rg.name
  virtual_network_name      = azurerm_virtual_network.vnet1.name
  remote_virtual_network_id = azurerm_virtual_network.vnet2.id
}

resource "azurerm_virtual_network_peering" "example-2" {
  name                      = "peer2to1"
  resource_group_name       = azurerm_resource_group.rg.name
  virtual_network_name      = azurerm_virtual_network.vnet2.name
  remote_virtual_network_id = azurerm_virtual_network.vnet1.id
}