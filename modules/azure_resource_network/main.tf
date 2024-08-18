locals {
  vnet_name    = var.vnet_name != "" ? var.vnet_name : "${var.resource_group_name}-vnet"
  subnet_name  = var.subnet_name != "" ? var.subnet_name : "${var.resource_group_name}-subnet"
}

resource "azurerm_virtual_network" "vnet" {
  name                = local.vnet_name
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = var.address_space
}

resource "azurerm_subnet" "subnet" {
  name                 = local.subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.subnet_prefix
}
