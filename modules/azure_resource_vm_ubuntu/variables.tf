variable "resource_group_name" {
  type        = string
}

variable "location" {
  type        = string
}

variable "vm_name" {
  type        = string
}

variable "vm_size" {
  type        = string
  default     = "Standard_B1s"
}

variable "admin_username" {
  type        = string
  default     = "azureuser"
}

variable "ssh_public_key" {
  type        = string
  default     = "~/.ssh/id_rsa.pub"
}

variable "ssh_private_key" {
  description = "Path to the SSH private key used to connect to the VM."
  type        = string
  default     = "~/.ssh/id_rsa"
}

variable "vnet_name" {
  type        = string
}

variable "subnet_name" {
  type        = string
}

variable "subnet_id" {
  type        = string
}
variable "public_ip_name" {
  type        = string
  default     = ""
}

variable "allowed_ports" {
  type        = list(number)
  default     = [22, 80, 443]
}

variable "image_publisher" {
  type = string
  default = "Canonical"
}

variable "image_offer" {
  type = string
  default = "0001-com-ubuntu-server-focal"
}

variable "image_sku" {
  type = string
  default = "20_04-lts-gen2"
}

variable "image_version" {
  type = string
  default = "20.04.202408090"
}
