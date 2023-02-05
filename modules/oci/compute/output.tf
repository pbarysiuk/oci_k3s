# output "k3s_servers_ips" {
#   depends_on = [
#     data.oci_core_instance_pool_instances.k3s_servers_instances,
#   ]
#   value = data.oci_core_instance.k3s_servers_instances_ips.*.public_ip
# }

# output "k3s_workers_ips" {
#   depends_on = [
#     data.oci_core_instance_pool_instances.k3s_workers_instances,
#   ]
#   value = data.oci_core_instance.k3s_workers_instances_ips.*.public_ip
# }

# output "oci_core_instance_k3s_servers_instances_ips" {
#   depends_on = [
#     data.oci_core_instance.k3s_servers_instances_ips
#   ]
#   value = data.oci_core_instance.k3s_servers_instances_ips
# }

output "oci_core_instance_pool_workers" {
  value = oci_core_instance_pool.k3s_workers
}

output "oci_core_instance_pool_servers" {
  value = oci_core_instance_pool.k3s_servers
}

output "oci_load_balancer_k3s_load_balancer" {
  value = oci_load_balancer_load_balancer.k3s_load_balancer
}