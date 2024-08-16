provider "azurerm" {
  features {}
}

module "network" {
  source = "./modules/azure_resources_network"

  resource_group_name          = "ClusterK8S"
  address_space                = ["10.0.0.0/16"]
  subnet_name                  = "default"
  subnet_prefixes              = ["10.0.0.0/24"]
}

module "vm" {
  source = "./modules/azure_resource_vm_ubuntu"

  vm_name             = "testubuntu"
  resource_group_name = module.network.resource_group_name
  location            = module.network.location
  vm_size             = "Standard_B1s"
  admin_username      = "azureuser"
  network_interface_id = module.network.network_interface_id
  public_key_path      = "~/.ssh/id_rsa.pub"
  image_publisher      = "Canonical"
  image_offer          = "0001-com-ubuntu-server-focal"
  image_sku            = "20_04-lts-gen2"
  image_version        = "20.04.202408090"
  #public_ip_address    = module.network.public_ip_address
}
