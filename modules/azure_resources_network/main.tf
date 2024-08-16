locals {
  virtual_network_name = var.virtual_network_name != "" ? var.virtual_network_name : "${var.resource_group_name}-network"
  public_ip_name = var.public_ip_name != "" ? var.public_ip_name : "${var.resource_group_name}-ip"
  network_interface_name = var.network_interface_name != "" ? var.network_interface_name : "${var.resource_group_name}-nic"
  ip_config_name = var.ip_config_name != "" ? var.ip_config_name : "${var.resource_group_name}-ip-config"
  network_security_group_name = var.network_security_group_name != "" ? var.network_security_group_name : "${var.resource_group_name}-nsg"
}

# Configuration du groupe de ressources
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

# Création du réseau virtuel
resource "azurerm_virtual_network" "vnet" {
  name                = local.virtual_network_name
  address_space       = var.address_space
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

# Création du sous-réseau
resource "azurerm_subnet" "subnet" {
  name                 = var.subnet_name
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.subnet_prefixes
}

# Création de l'IP publique
resource "azurerm_public_ip" "public_ip" {
  name                = local.public_ip_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = var.public_ip_allocation_method
  sku                 = var.public_ip_sku
}

# Création de l'interface réseau
resource "azurerm_network_interface" "nic" {
  name                = local.network_interface_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = local.ip_config_name
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = var.private_ip_allocation
    public_ip_address_id          = azurerm_public_ip.public_ip.id
  }
}

# Group de sécurité réseau
resource "azurerm_network_security_group" "nsg" {
  name                = local.network_security_group_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  dynamic "security_rule" {
    for_each = var.security_rules
    content {
      name                       = security_rule.value.name
      priority                   = security_rule.value.priority
      direction                  = security_rule.value.direction
      access                     = security_rule.value.access
      protocol                   = security_rule.value.protocol
      source_port_range          = security_rule.value.source_port_range
      destination_port_ranges    = security_rule.value.destination_port_ranges
      source_address_prefix      = security_rule.value.source_address_prefix
      destination_address_prefix = security_rule.value.destination_address_prefix
    }
  }
}

# Association du NSG avec l'interface réseau
resource "azurerm_network_interface_security_group_association" "nic_nsg" {
  network_interface_id      = azurerm_network_interface.nic.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}
