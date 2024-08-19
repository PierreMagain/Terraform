resource "null_resource" "docker_install" {
  count = var.assign_docker ? 1 : 0

  provisioner "file" {
    source      = "/home/magainp/Documents/Terraform/modules/docker_install/scripts/docker_install.sh"
    destination = "/tmp/docker_install.sh"

    connection {
      type        = "ssh"
      user        = var.ssh_user
      private_key = file(var.ssh_private_key)
      host        = var.vm_ip
    }
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/docker_install.sh",
      "sudo /tmp/docker_install.sh"
    ]

    connection {
      type        = "ssh"
      user        = var.ssh_user
      private_key = file(var.ssh_private_key)
      host        = var.vm_ip
    }
  }
}
