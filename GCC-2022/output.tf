locals {
  key   = "~/.ssh/${var.key_pair}.pem"
  ips   = openstack_compute_floatingip_v2.floating_ips
  nodes = openstack_compute_instance_v2.nodes
}

resource "local_file" "inventories" {
  count    = var.num_nodes
  content  = templatefile("./templates/inventory.tpl", { ip = local.ips[count.index].address, key = local.key, name = local.nodes[count.index].name })
  filename = pathexpand("./inventories/${var.namespace}-${var.instance_name}-${count.index + var.node_offset + 1}.ini")
}

resource "local_file" "master-inventories" {
  content  = templatefile("./templates/master-inventory.tpl", { ips = local.ips, key = local.key, basename = "${var.namespace}-${var.instance_name}" })
  filename = pathexpand("./inventories/${var.namespace}-${var.instance_name}.ini")
}
