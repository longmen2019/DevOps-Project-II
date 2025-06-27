output "resource_group_name" {
  value = azurerm_resource_group.rg.name
}

output "acr_login_server" {
    value = azurerm_container_registry.acr.login_server
  
}

output "public_ip_address" {
  value = azurerm_linux_virtual_machine.my_terraform_vm.public_ip_address
}