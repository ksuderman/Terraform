variable "namespace" {
  description = "A unique string used when generating resource names"
  type        = string
  default     = "gcc2022"
}

variable "instance_name" {
  description = "FQDN will be formed from instance_name + [count.index] + '.' + domain"
  type        = string
  default     = "admin"
}

variable "num_nodes" {
  description = "number of VMs to be created"
  type        = number
  default     = 30
}

variable "node_offset" {
  description = "value to be added to the count.index when generating instance names"
  type        = number
  default     = 0
}

variable "network" {
  description = "Network to use. Must already exist"
  type        = string
  default     = "gcc-2022"
}

variable "image" {
  description = "the name of the OS image to use when creating the VM."
  type        = string
  #default     = "JS-API-Featured-Ubuntu20-Latest"
  default = "Featured-Ubuntu20"
}

variable "flavor" {
  description = "VM instance type to be created."
  type        = string
  default     = "m3.small"
}

variable "key_pair" {
  description = "the name of the SSH key pair to use."
  type        = string
  default     = "gcc-2022"
}


variable "public_ports" {
  description = "the ports to be opened to the world"
  type        = set(string)
  default     = ["22", "80", "443", "6443", "8000", "8080", "8443"]
}


