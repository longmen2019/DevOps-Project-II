output "public_ip_id" {
  description = "The ID of the Public IP address"
  value       = azurerm_public_ip.pub_ip.id
}

output "public_ip_address" {
  description = "The actual Public IP address assigned"
  value       = azurerm_public_ip.pub_ip.ip_address
}

output "public_ip_name" {
  description = "The name of the Public IP resource"
  value       = azurerm_public_ip.pub_ip.name
}
