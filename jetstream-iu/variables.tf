variable "namespace" {
  description = "A unique string used when generating resource names"
  type        = string
  default     = "ks-helm"
}

variable "instance_name" {
  description = "FQDN will be formed from instance_name + [count.index] + '.' + domain"
  type = string
  default = "helm"
}

# variable "num_nodes" {
#   description = "number of VMs to be created"
#   type        = number
#   default     = 1
# }

variable "disk_size" {
  description = "size of the volume to attache to each node"
  type        = number
  default     = 500
}

variable "dns_zone_cloudve" {
  description = "The DNS zone ID for cloudve.org"
  type = string
  default = "Z2OP3FQQJKSF4S"
}

variable "dns_zone_usegvl" {
  description = "the DNS zone ID for usegvl.org"
  type = string
  default = "Z01092892MLURSVI2K4L4"
}

variable "domain" {
  description = "domain name assocuated with the zone name ID above"
  type = string
  default = "usegvl.org"
}

variable dns_zone_id {
  description = "the DNS zone ID"
  type = string
  default = "Z01092892MLURSVI2K4L4"
}
variable "image" {
  description = "the name of the OS image to use when creating the VM."
  type        = string
  default     = "JS-API-Featured-Ubuntu20-Latest"
}

variable "num_nodes" {
  description = "the number of VMs to be launched"
  type = number
  default = 1
}

variable "flavor" {
  description = "VM instance type to be created."
  type        = string
  default     = "m1.medium"
}

variable "flavors" {
  description = "Instance types (flavors) to be launched"
  type = list(string)
  default = ["quad", "medium", "large", "xlarge"]
}

variable "key_pair" {
  description = "the name of the SSH key pair to use."
  type        = string
  default     = "ks-cluster"
}

variable "ssh_key_file" {
  description = "the ssh key used to connect to the instance(s)"
  type = string
  default = "~/.ssh/ks-cluster.pem"
}

variable "mount_point" {
  description = "Directory where the volume will be mounted"
  type = string
  default = "/opt/local-path-provisioner"
}

variable "network" {
  description = "the name of the network to connect to."
  type        = string
  default     = "ks-network"
}

variable "public_ports" {
  description = "the ports to be opened to the world"
  type        = set(string)
  default     = ["22", "80", "443", "6443", "8000", "8080", "8443"]
}

variable "private_ports" {
  description = "ports only open to other nodes in the cluster"
  type = set(string)
  default = [ "179", "2376", "2379", "2380", "6783", "6784", "9099", "9100", "9443", "9796", "10250", "10254"]
}

variable "udp_ports" {
  description = "UDP ports open to other nodes in the cluster"
  type = set(string)
  default = [ "4789", "6783", "6784", "8472" ]
}

