
resource "openstack_networking_secgroup_v2" "fw" {
  name = "${var.namespace}-firewall"
  description = "[tf] Security group for ${var.namespace}"
  delete_default_rules = true
}

resource "openstack_networking_secgroup_rule_v2" "egress_ip4" {
  direction         = "egress"
  ethertype         = "IPv4"
  security_group_id = "${openstack_networking_secgroup_v2.fw.id}"
}

resource "openstack_networking_secgroup_rule_v2" "ipv4_tcp_public" {
  for_each          = var.public_ports
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = each.value
  port_range_max    = each.value
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.fw.id
}


