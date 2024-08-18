output "vnet_name" {
  description = "Le nom du réseau virtuel créé."
  value       = azurerm_virtual_network.vnet.name
}

output "vnet_address_space" {
  description = "L'espace d'adressage du réseau virtuel."
  value       = azurerm_virtual_network.vnet.address_space
}

output "subnet_name" {
  description = "Le nom du sous-réseau créé."
  value       = azurerm_subnet.subnet.name
}

output "subnet_address_prefixes" {
  description = "La plage d'adresses du sous-réseau."
  value       = azurerm_subnet.subnet.address_prefixes
}

output "subnet_id" {
  description = "L'ID complet du sous-réseau créé."
  value       = azurerm_subnet.subnet.id
}

