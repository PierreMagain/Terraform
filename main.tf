provider "azurerm" {
  features {}
}

module "resource_group" {
  source              = "./modules/azure_resource_group_name"
  resource_group_name = "Test"
  location            = "Germany West Central"
}

module "network" {
  source              = "./modules/azure_resource_network"
  resource_group_name = module.resource_group.resource_group_name
  location            = module.resource_group.resource_group_location
  address_space       = ["192.168.0.0/16"]
  subnet_prefix       = ["192.168.0.0/24"]
  vnet_name           = ""
  subnet_name         = ""
}

module "vm1" {
  source              = "./modules/azure_resource_vm_ubuntu"
  resource_group_name = module.resource_group.resource_group_name
  location            = module.resource_group.resource_group_location
  vm_name             = "test1"
  vm_size             = "Standard_B1s"
  admin_username      = "azureuser"
  ssh_public_key      = "~/.ssh/id_rsa.pub"
  vnet_name           = module.network.vnet_name
  subnet_name         = module.network.subnet_name
  subnet_id           = module.network.subnet_id
  image_publisher     = "Canonical"
  image_offer         = "0001-com-ubuntu-server-focal"
  image_sku           = "20_04-lts-gen2"
  image_version       = "20.04.202408090"
}

module "vm2" {
  source              = "./modules/azure_resource_vm_ubuntu"
  resource_group_name = module.resource_group.resource_group_name
  location            = module.resource_group.resource_group_location
  vm_name             = "test2"
  vm_size             = "Standard_B1s"
  admin_username      = "azureuser"
  ssh_public_key      = "~/.ssh/id_rsa.pub"
  vnet_name           = module.network.vnet_name
  subnet_name         = module.network.subnet_name
  subnet_id           = module.network.subnet_id
  image_publisher     = "Canonical"
  image_offer         = "0001-com-ubuntu-server-focal"
  image_sku           = "20_04-lts-gen2"
  image_version       = "20.04.202408090"
}
