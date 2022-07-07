resource "openstack_compute_instance_v2" "nodes" {
  count           = var.num_nodes
  name            = "${var.namespace}-${count.index + 1}"
  image_name      = var.image
  flavor_name     = var.flavor
  key_pair        = var.key_pair
  security_groups = [openstack_networking_secgroup_v2.fw.id, "default"]

  network {
    name = var.network
  }
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

resource "null_resource" "mount_volumes" {
  count = var.num_nodes

  connection {
    type     = "ssh"
    user     = "ubuntu"
    host     = openstack_compute_floatingip_v2.floating_ips[count.index].address
    private_key = "${file(local.key)}"
  }

  provisioner "file" {
    source = "files/system-init.sh"
    destination = "/home/ubuntu/system-init.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo bash /home/ubuntu/system-init.sh ${openstack_compute_volume_attach_v2.attached[count.index].device} ${var.mount_point}"
    ]
  }
