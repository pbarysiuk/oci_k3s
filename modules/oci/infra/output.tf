# output "public_lb_ip" {
#   value = oci_network_load_balancer_network_load_balancer.k3s_public_lb.ip_addresses
# }

# output "oci_load_balancer_k3s_load_balancer" {
#   value = oci_load_balancer_load_balancer.k3s_load_balancer
# }
output "oci_core_subnet10" {
  value = oci_core_subnet.default_oci_core_subnet10
}

output "oci_core_subnet11" {
  value = oci_core_subnet.oci_core_subnet11
}

output "public_lb_ip" {
  value = local.public_lb_ip
}

output "nsg_http" {
  value = oci_core_network_security_group.lb_to_instances_http
}

output "nsg_kubeapi" {
  value = oci_core_network_security_group.lb_to_instances_kubeapi
}

output "compute_dynamic_group" {
  value = oci_identity_dynamic_group.compute_dynamic_group
}

# output "compute_dynamic_policy" {
#   value = oci_identity_dynamic_group.compute_dynamic_group_policy
# }

output "k3s_servers_instances_ips" {
  value = data.oci_core_instance.k3s_servers_instances_ips
}