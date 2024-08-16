variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
  default = "Germany West Central"
}

variable "virtual_network_name" {
  type = string
  default = ""
}

variable "address_space" {
  type = list(string)
}

variable "subnet_name" {
  type = string
}

variable "subnet_prefixes" {
  type = list(string)
}

variable "public_ip_name" {
  type = string
  default = ""
}

variable "public_ip_allocation_method" {
  type = string
  default = "Static"
}

variable "public_ip_sku" {
  type = string
  default = "Standard"
}

variable "network_interface_name" {
  type = string
  default = ""
}

variable "ip_config_name" {
  type = string
  default = ""
}

variable "private_ip_allocation" {
  type = string
  default = "Dynamic"
}

variable "network_security_group_name" {
  type = string
  default = ""
}

variable "security_rules" {
  type = list(object({
    name                       = string
    priority                   = number
    direction                  = string
    access                     = string
    protocol                   = string
    source_port_range          = string
    destination_port_ranges    = list(string)
    source_address_prefix      = string
    destination_address_prefix = string
  }))

  default = [
    {
      name                       = "allow_ssh"
      priority                   = 1001
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_ranges    = ["22"]
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    },
    {
      name                       = "allow_http"
      priority                   = 1002
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_ranges    = ["80"]
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    },
    {
      name                       = "allow_https"
      priority                   = 1003
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_ranges    = ["443"]
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    }
  ]
}
