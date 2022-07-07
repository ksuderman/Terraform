# module "network" {
#   source = "../modules/os"
#   name = "rancher"
#   cidr = "192.168.199.0/24"
# }

# data "openstack_images_image_v2" "ubuntu20" {
#   name = var.image
#   most_recent = true
# }

resource "openstack_compute_instance_v2" "nodes" {
  count = var.num_nodes
  name            = "${var.namespace}${count.index + 1}"
  image_name      = var.image
  flavor_name     = var.flavor
  key_pair        = var.key_pair
  security_groups = [openstack_networking_secgroup_v2.fw.id, "default"]
  network {
    name = var.network
  }
  # depends_on = ["module.network"]
}

resource "openstack_compute_floatingip_v2" "floating_ips" {
  pool  = "public"
  count = var.num_nodes
}

resource "openstack_compute_floatingip_associate_v2" "node_ips" {
  count       = var.num_nodes
  floating_ip = openstack_compute_floatingip_v2.floating_ips[count.index].address
  instance_id = openstack_compute_instance_v2.nodes[count.index].id
}

