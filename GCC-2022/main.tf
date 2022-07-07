resource "openstack_compute_instance_v2" "nodes" {
  count           = var.num_nodes
  name            = "${var.namespace}-${var.instance_name}-${count.index + var.node_offset + 1}"
  image_name      = var.image
  flavor_name     = var.flavor
  key_pair        = var.key_pair
  security_groups = [ openstack_networking_secgroup_v2.fw.id, "default" ]
  #security_groups = ["default"]
  network {
    #port = "${openstack_networking_port_v2.port.id}"
    name = var.network
  }
}

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
  #public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCfOooDqFPAeeYYdXzY6BNSFga5QjdXAorwTWXmaTUv49qQWGcEioIlXTFo0bPSekd7ZHUyi6qJ7RaODNZkligwCkhg9+4jwAF8pvsTRH77MU9NC9Im3nz9hqzSvvfpGHpXoVmWoWt1SdI5+T3dHf05dsGm30/rJYa0E1/mZw+cKlsxkQXbxUhanoqnstADvd26yBYkN7lQpyRBTDwcOGX939M1E5qo1J2gSbtWQJVoZ3dNQk5pf88tCH5lZVIHbBQLgDY/MknSRp8hbZALvA4WMOSBCC7+fAVhYpwKb0ALmtX3eERi16gCSUAZrJmgIafmSvSDdhUa2eOUy5he2SB1"
}