output "vm_name" {
  description = "Le nom de la machine virtuelle."
  value       = azurerm_linux_virtual_machine.vm.name
}

output "public_ip_address" {
  description = "L'adresse IP publique de la VM."
  value       = azurerm_public_ip.public_ip.ip_address
}

output "admin_username" {
  description = "Le nom d'utilisateur administrateur pour la VM."
  value       = var.admin_username
}
