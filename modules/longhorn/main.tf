resource "helm_release" "longhorn" {
  name             = "longhorn"
  repository       = "https://charts.longhorn.io"
  chart            = "longhorn"
  namespace        = "longhorn-system"
  create_namespace = true
  version          = var.chart_version

  set {
    name  = "createDefaultDiskLabeledNodes"
    value = true
  }
}

# There's no way to delete a resource from within Terraform, so this is the only way to go. 
# Unless I can find another chart where the service port and type can be set ...

# resource "null_resource" "delete_longhorn_lb_svc" {
#   depends_on = [
#     helm_release.longhorn
#   ]
#   provisioner "local-exec" {
#     command = "KUBECONFIG=./kubeconfig-k3s kubectl delete svc longhorn-frontend -n longhorn-system"
#   }
# }

# # Now recreate the one I need 
# resource "kubernetes_service" "longhorn-frontend" {
#   depends_on = [
#     null_resource.delete_longhorn_lb_svc
#   ]
#   metadata {
#     name      = "longhorn-frontend"
#     namespace = "longhorn-system"
#   }
#   spec {
#     selector = {
#       app = "longhorn-ui"
#     }
#     session_affinity = "ClientIP"
#     port {
#       port        = 6680
#       target_port = 8000
#     }

#     type = "LoadBalancer"
#   }
# }

# resource "null_resource" "create_longhorn_lb_svc" {
#   depends_on = [
#     kubernetes_service.longhorn-frontend
#   ]
#   provisioner "local-exec" {
#     command = <<EOT
#     KUBECONFIG=./kubeconfig-k3s kubectl patch storageclass local-path -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"false"}}}'
#     EOT
#   }
# }