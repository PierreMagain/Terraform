variable "resource_group_name" {
  description = "Le nom du groupe de ressources où le VNet sera créé."
  type        = string
}

variable "location" {
  description = "La région Azure où le VNet sera créé."
  type        = string
}

variable "address_space" {
  description = "L'espace d'adressage IPv4 du réseau virtuel."
  type        = list(string)
}

variable "subnet_prefix" {
  description = "La plage d'adresses IPv4 du sous-réseau."
  type        = list(string)
}

# Variables optionnelles avec valeurs par défaut
variable "vnet_name" {
  description = "Le nom du réseau virtuel."
  type        = string
  default     = null
}

variable "subnet_name" {
  description = "Le nom du sous-réseau."
  type        = string
  default     = null
}
