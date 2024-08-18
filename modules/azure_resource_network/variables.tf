variable "resource_group_name" {
  type        = string
}

variable "location" {
  type        = string
}

variable "address_space" {
  type        = list(string)
}

variable "subnet_prefix" {
  type        = list(string)
}

# Variables optionnelles avec valeurs par défaut
variable "vnet_name" {
  type        = string
  default     = ""
}

variable "subnet_name" {
  type        = string
  default     = ""
}
