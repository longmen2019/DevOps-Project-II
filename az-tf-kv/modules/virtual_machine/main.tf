
resource "azurerm_virtual_machine" "main" {
  name                  = "${var.prefix}-vm"
  location              = var.rg_location
  resource_group_name   = var.rg_name
  network_interface_ids = var.nic_id
  vm_size               = var.vm_size

  # Uncomment this line to delete the OS disk automatically when deleting the VM
  delete_os_disk_on_termination = true

  # Uncomment this line to delete the data disks automatically when deleting the VM
  delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = var.publisher 
    offer     = var.offer 
    sku       = var.sku
    version   = "latest"
  }
  storage_os_disk {
    name              = "myosdisk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
    os_profile {
    computer_name  = "${var.prefix}-vm"
    admin_username = var.admin_username
    admin_password = var.admin_password 
  }

  os_profile_linux_config {
    disable_password_authentication = true
    ssh_keys {
      path     = "/home/${var.admin_username}/.ssh/authorized_keys"
      key_data = var.ssh_public_key
    }
  }

  identity {
  type = "SystemAssigned"
}

}
