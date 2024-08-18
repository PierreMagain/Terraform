variable "resource_group_name" {
  description = "Le nom du groupe de ressources où la VM sera créée."
  type        = string
}

variable "location" {
  description = "La région Azure où la VM sera créée."
  type        = string
}

variable "vm_name" {
  description = "Le nom de la machine virtuelle."
  type        = string
}

variable "vm_size" {
  description = "La taille de la machine virtuelle."
  type        = string
  default     = "Standard_B1s"
}

variable "admin_username" {
  description = "Le nom d'utilisateur administrateur pour la VM."
  type        = string
  default     = "azureuser"
}

variable "ssh_public_key" {
  description = "La clé publique SSH pour l'accès à la VM."
  type        = string
  default     = "~/.ssh/id_rsa.pub"
}

variable "vnet_name" {
  description = "Le nom du réseau virtuel existant."
  type        = string
}

variable "subnet_name" {
  description = "Le nom du sous-réseau existant."
  type        = string
}

variable "subnet_id" {
  description = "L'ID complet du sous-réseau."
  type        = string
}
variable "public_ip_name" {
  description = "Le nom de l'adresse IP publique à associer à la VM."
  type        = string
  default = ""
}

variable "allowed_ports" {
  description = "Liste des ports à autoriser pour les connexions entrantes."
  type        = list(number)
  default     = [22, 80, 443]
}

variable "image_publisher" {
  type = string
}

variable "image_offer" {
  type = string
}

variable "image_sku" {
  type = string
}

variable "image_version" {
  type = string
}