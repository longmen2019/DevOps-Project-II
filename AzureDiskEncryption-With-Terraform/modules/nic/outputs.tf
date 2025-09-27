output "nic_id" {
  description = "The ID of the created Network Interface"
  value       = azurerm_network_interface.nic.id
}

output "nic_name" {
  description = "The name of the created Network Interface"
  value       = azurerm_network_interface.nic.name
}

output "nic_private_ip" {
  description = "The private IP address assigned to the NIC"
  value       = try(azurerm_network_interface.nic.ip_configuration[0].private_ip_address, null)
}

output "nic_location" {
  description = "The location where the NIC was deployed"
  value       = azurerm_network_interface.nic.location
}
