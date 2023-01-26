output "public_lb_ip" {
  value = oci_network_load_balancer_network_load_balancer.k3s_public_lb.ip_addresses
}