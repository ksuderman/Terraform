resource "openstack_compute_instance_v2" "nodes" {
  count           = var.num_nodes
  name            = "${var.namespace}-${var.instance_name}-${count.index + var.node_offset + 1}"
  image_name      = var.image
  flavor_name     = var.flavor
  key_pair        = openstack_compute_keypair_v2.user_key.name
  security_groups = [ "gcc2022-firewall", "default" ]
  #security_groups = ["default"]
  network {
    #port = "${openstack_networking_port_v2.port.id}"
    name = var.network
  }
}

resource "openstack_networking_router_v2" "router-1" {
  #name                = "${var.namespace}-router"
  name                = "gcc-router"
  admin_state_up      = true
  external_network_id = "3fe22c05-6206-4db2-9a13-44f04b6796e6" # public

}

# TODO
#resource "openstack_networking_router_interface_v2" "router_interface_1" {
  #router_id = openstack_networking_router_v2.router-1.id
  #subnet_id = "gcc-subnet"
#}

resource "openstack_compute_floatingip_v2" "floating_ips" {
  count = var.num_nodes
  pool  = "public"
}

resource "openstack_compute_floatingip_associate_v2" "node_ip" {
  count = var.num_nodes
  floating_ip = openstack_compute_floatingip_v2.floating_ips[count.index].address
  instance_id = openstack_compute_instance_v2.nodes[count.index].id
}

resource "openstack_compute_keypair_v2" "user_key" {
  name       = var.key_pair
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC/Fr2l4Io0cv+xFO7G6OaFda9KIAmK3ZbtyDPH1jcPs0s06o5/R+wUTUPr4Phj9g7x1341EFN5C3Oxr22DVi/5a8MiRrJodWCrxUSFpgK7NUaRDaluD2Ev7+ro/MS+m/DP/UncwwHqNqVjZ3m9tHsxMJUsZl2im+S9jiFCibRE0/hGdnCh5EnrLkIcW7fKcVEIsgRaFRl15L512mdO95EY0y+0dfO7emB5pFRpc4hr8Bo0a/IJhsU2INZqNCrTFmcBuyQrcXz62MJyWSSjj0SUX9HVtgKpUy3YWOq/1yxs1Lh0NtVwvuCYTbTGoXz2xupN0nzjFAKzWPsoi1VQI2Yv"
}
