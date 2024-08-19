variable "assign_docker" {
  description = "True if Docker should be installed on the VM."
  type        = bool
  default     = false
}

variable "ssh_user" {
  description = "SSH username to connect to the VM."
  type        = string
}

variable "ssh_private_key" {
  description = "Path to the SSH private key."
  type        = string
}

variable "vm_ip" {
  description = "Public IP of the VM."
  type        = string
}

variable "vm_depends_on" {
  description = "List of resources that Docker installation depends on"
  type        = list(any)
  default     = []
}

