resource "azurerm_resource_group" "rg_lm" {
  name     = "${var.prefix}-resources"
  location = "West Europe"
}

resource "azurerm_virtual_network" "vnet_lm" {
  name                = "${var.prefix}-network"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg_lm.location
  resource_group_name = azurerm_resource_group.rg_lm.name
}

resource "azurerm_subnet" "snet_lm" {
  name                 = "internal"
  resource_group_name  = azurerm_resource_group.rg_lm.name
  virtual_network_name = azurerm_virtual_network.vnet_lm.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_network_interface" "nic_lm" {
  name                = "${var.prefix}-nic"
  location            = azurerm_resource_group.rg_lm.location
  resource_group_name = azurerm_resource_group.rg_lm.name

  ip_configuration {
    name                          = "testconfiguration1"
    subnet_id                     = azurerm_subnet.snet_lm.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_virtual_machine" "main" {
  name                  = "${var.prefix}-vm"
  location              = azurerm_resource_group.rg_lm.location
  resource_group_name   = azurerm_resource_group.rg_lm.name
  network_interface_ids = [azurerm_network_interface.nic_lm.id]
  vm_size               = "Standard_F2"

  # Uncomment this line to delete the OS disk automatically when deleting the VM
  # delete_os_disk_on_termination = true

  # Uncomment this line to delete the data disks automatically when deleting the VM
  # delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
  storage_os_disk {
    name              = "myosdisk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "hostname"
    admin_username = "testadmin"
    admin_password = "Password1234!"
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
  tags = {
    environment = "staging"
  }
}