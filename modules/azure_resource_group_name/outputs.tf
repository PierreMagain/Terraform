output "resource_group_name" {
  description = "Le nom du groupe de ressources créé."
  value       = azurerm_resource_group.rg.name
}

output "resource_group_location" {
  description = "La région du groupe de ressources créé."
  value       = azurerm_resource_group.rg.location
}
