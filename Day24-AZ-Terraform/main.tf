resource "azurerm_resource_group" "rg" {
  name     = "${var.DAY}-rg"
  location = "${var.location}"
}


resource "azurerm_virtual_network" "vnet" {
  name                = "example-vnet-lm"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_subnet" "sn" {
  name                 = "example-subnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]

  
}

resource "azurerm_service_plan" "name" {
  name                = "${var.DAY}-pan"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  os_type             = "Linux"
  sku_name            = "B1"
}

resource "azurerm_linux_web_app" "name" {
  name                = "${var.DAY}-webapp-lm"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_service_plan.name.location
  service_plan_id     = azurerm_service_plan.name.id

  site_config {
    application_stack {
      node_version = "18-lts"
    }
  }
}