output "vm_name" {
  value       = azurerm_linux_virtual_machine.vm.name
}

output "public_ip_address" {
  value       = var.assign_public_ip ? azurerm_public_ip.public_ip[0].ip_address : null
}

output "admin_username" {
  value       = var.admin_username
}
