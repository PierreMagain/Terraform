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
}

# module "vm1" {
#   source              = "./modules/azure_resource_vm_ubuntu"
#   resource_group_name = module.resource_group.resource_group_name
#   location            = module.resource_group.resource_group_location
#   vnet_name           = module.network.vnet_name
#   subnet_name         = module.network.subnet_name
#   subnet_id           = module.network.subnet_id
#   vm_name             = "proxy"
#   vm_size             = "Standard_B1s"
#   assign_public_ip    = true
# }

module "vm1" {
  source              = "./modules/azure_resource_vm_ubuntu"
  resource_group_name = module.resource_group.resource_group_name
  location            = module.resource_group.resource_group_location
  vnet_name           = module.network.vnet_name
  subnet_name         = module.network.subnet_name
  subnet_id           = module.network.subnet_id
  vm_name             = "master"
  vm_size             = "Standard_B1s"
  assign_public_ip    = true
}

module "vm2" {
  source              = "./modules/azure_resource_vm_ubuntu"
  resource_group_name = module.resource_group.resource_group_name
  location            = module.resource_group.resource_group_location
  vnet_name           = module.network.vnet_name
  subnet_name         = module.network.subnet_name
  subnet_id           = module.network.subnet_id
  vm_name             = "node1"
  vm_size             = "Standard_B1s"
  assign_public_ip    = true
}

module "vm3" {
  source              = "./modules/azure_resource_vm_ubuntu"
  resource_group_name = module.resource_group.resource_group_name
  location            = module.resource_group.resource_group_location
  vnet_name           = module.network.vnet_name
  subnet_name         = module.network.subnet_name
  subnet_id           = module.network.subnet_id
  vm_name             = "node2"
  vm_size             = "Standard_B1s"
  assign_public_ip    = true
}


resource "null_resource" "update_known_hosts" {
  
  depends_on = [
    module.vm1,
    module.vm2,
    module.vm3
  ]
   provisioner "local-exec" {
    command = <<EOT
      sleep 30
      export VM1_IP=${module.vm1.public_ip_address}
      export VM2_IP=${module.vm2.public_ip_address}
      export VM3_IP=${module.vm3.public_ip_address}
      /home/magainp/Documents/Terraform/scripts/add_known_hosts.sh
    EOT
  }
}


resource "local_file" "ansible_inventory" {
  depends_on = [null_resource.update_known_hosts]
  
  content = templatefile("/home/magainp/Documents/Terraform/inventory.tpl", {
    vm1_name  = module.vm1.vm_name,
    vm1_ip    = module.vm1.public_ip_address,
    vm1_user  = module.vm1.admin_username,
    vm2_name  = module.vm2.vm_name,
    vm2_ip    = module.vm2.public_ip_address,
    vm2_user  = module.vm2.admin_username,
    vm3_name  = module.vm3.vm_name,
    vm3_ip    = module.vm3.public_ip_address,
    vm3_user  = module.vm3.admin_username
  })
  filename = "/home/magainp/Documents/Terraform/inventory.ini"
}
resource "null_resource" "ansible_provision" {
  depends_on = [local_file.ansible_inventory]

  provisioner "local-exec" {
    command = "ansible-playbook -i /home/magainp/Documents/Terraform/inventory.ini /home/magainp/Documents/Terraform/playbook.yml"
  }
}