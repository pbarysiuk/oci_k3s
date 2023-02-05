module "infra" {
  source                         = "./modules/oci/infra"
  region                         = var.region
  availability_domain            = var.availability_domain
  tenancy_ocid                   = var.tenancy_ocid
  compartment_ocid               = var.compartment_ocid
  my_public_ip_cidr              = var.my_public_ip_cidr
  cluster_name                   = var.cluster_name
  environment                    = var.environment
  os_image_id                    = var.os_image_id
  oci_core_instance_pool_workers = module.compute.oci_core_instance_pool_workers
  oci_core_instance_pool_servers = module.compute.oci_core_instance_pool_servers
}

module "compute" {
  source                    = "./modules/oci/compute"
  region                    = var.region
  tenancy_ocid              = var.tenancy_ocid
  compartment_ocid          = var.compartment_ocid
  my_public_ip_cidr         = var.my_public_ip_cidr
  cluster_name              = var.cluster_name
  availability_domain       = var.availability_domain
  environment               = var.environment
  os_image_id               = var.os_image_id
  oci_core_subnet10         = module.infra.oci_core_subnet10
  oci_core_subnet11         = module.infra.oci_core_subnet11
  public_lb_ip              = module.infra.public_lb_ip
  nsg_http                  = module.infra.nsg_http
  nsg_kubeapi               = module.infra.nsg_kubeapi
  compute_dynamic_group     = module.infra.compute_dynamic_group
  k3s_servers_instances_ips = module.infra.k3s_servers_instances_ips
  #oci_load_balancer_k3s_load_balancer = module.infra.oci_load_balancer_k3s_load_balancer
}

# module "longhorn" {
#   source        = "./modules/longhorn"
#   chart_version = var.longhorn_release
#   depends_on = [module.oci]
# }

# module "nginx-ingress" {
#   source = "./modules/nginx-ingress"
#   depends_on = [module.oci]
# }

# module "cert-manager" {
#   source = "./modules/cert-manager"
#   //depends_on = [module.oci, module.nginx-ingress]
# }

# module "prometheus" {
#   source = "./modules/prometheus"
#   depends_on = [module.oci]
# }

# module "deployment_echo" {
#   source      = "./deployments/test"
#   name        = "echo-test"
#   environment = var.environment
#   depends_on = [module.oci]
# }

# module "deployment_kuard" {
#   source      = "./deployments/kuard"
#   #name        = "echo-test"
#   #environment = var.environment
#   depends_on = [module.oci]
# }

# module "grafana" {
#   source = "./modules/grafana"
# }

# module "elk" {
#   source = "./modules/elk"
# }

# output "oci_lb_ip" {
#   value = module.infra.public_lb_ip
# }
# output "oci_master_ip" {
#   value = module.compute.k3s_servers_ips
# }
# output "oci_worker_ip" {
#   value = module.compute.k3s_workers_ips
# }