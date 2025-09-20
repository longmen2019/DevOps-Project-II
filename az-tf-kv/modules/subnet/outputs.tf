output "subnet_id" {
  description = "The ID of the subnet"
  value       = azurerm_subnet.snet.id
}

output "subnet_name" {
  description = "The name of the subnet"
  value       = azurerm_subnet.snet.name
}

output "subnet_address_prefixes" {
  description = "The address prefixes assigned to the subnet"
  value       = azurerm_subnet.snet.address_prefixes
}
