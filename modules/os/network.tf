variable "name" {
  type = string
}
variable "cidr" {
  type = string
  default = "192.168.199.0/24"
}
resource "openstack_networking_network_v2" "network" {
  name           = "${var.name}_network"
  admin_state_up = "true"
}

resource "openstack_networking_subnet_v2" "subnet" {
  name       = "${var.name}_subnet"
  network_id = "${openstack_networking_network_v2.network.id}"
  cidr       = "${var.cidr}"
  ip_version = 4
}

#resource "openstack_networking_port_v2" "port" {
#  name               = "rancher_port"
#  network_id         = "${openstack_networking_network_v2.network.id}"
#  admin_state_up     = "true"
#  security_group_ids = ["${openstack_networking_secgroup_v2.fw.id}"]
#  fixed_ip {
#    subnet_id  = "${openstack_networking_subnet_v2.subnet.id}"
#    ip_address = "192.168.199.10"
#  }
#}

resource "openstack_networking_router_v2" "router" {
  name           = "${fvar.name}_router"
  admin_state_up = "true"
}


resource "openstack_networking_router_interface_v2" "interface" {
  router_id = "${openstack_networking_router_v2.router.id}"
  subnet_id = "${openstack_networking_subnet_v2.subnet.id}"
}
