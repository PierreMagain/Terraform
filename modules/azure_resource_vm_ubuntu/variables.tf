variable "vm_name" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "vm_size" {
  type = string
}

variable "admin_username" {
  type = string
}

variable "network_interface_id" {
  type = string
}

variable "public_key_path" {
  type = string
}

variable "os_disk_type" {
  type = string
  default = "StandardSSD_ZRS"
}

variable "os_disk_size" {
  type = number
  default = 30
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
