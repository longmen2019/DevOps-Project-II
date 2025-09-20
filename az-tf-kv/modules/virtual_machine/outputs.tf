output "vm_id" {
  description = "The ID of the Virtual Machine"
  value       = azurerm_virtual_machine.main.id
}

output "vm_name" {
  description = "The name of the Virtual Machine"
  value       = azurerm_virtual_machine.main.name
}

output "vm_os_disk_id" {
  description = "The ID of the OS disk attached to the VM"
  value       = azurerm_virtual_machine.main.storage_os_disk[0].managed_disk_id
}

output "vm_principal_id" {
  description = "The principal ID of the VM's system-assigned identity"
  value       = azurerm_virtual_machine.main.identity[0].principal_id
}
