output "admin_username" {
  value = var.admin_username
}

output "ssh_public_key" {
  value = var.ssh_public_key
}

output "public_ip_address" {
  value = module.pub_ip.public_ip_address
}

output "vm_name" {
  value = module.vm.vm_name
}

output "resource_group_name" {
  value = var.rg_name
}
