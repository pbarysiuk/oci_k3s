resource "helm_release" "helm-ingress_nginx" {
  name             = "ingress-nginx"
  repository       = "https://kubernetes.github.io/ingress-nginx/"
  chart            = "ingress-nginx"
  namespace        = "ingress-nginx"
  create_namespace = true

  set {
    name  = "controller.service.loadBalancerIP"
    value = "130.61.137.199"
  }
  # set {
  #   name = "controller.service.type"
  #   value = "NodePort"
  # }
  # set {
  #   name = "controller.hostNetwork"
  #   value = "true"
  # }
  # set {
  #   name = "controller.service.httpPort.nodePort"
  #   value = "30080"
  # }
  # set {
  #   name = "controller.service.httpsPort.nodePort"
  #   value = "30443"
  # }
  set {
    name  = "defaultBackend.enabled"
    value = "false"
  }
  // enable proxy protocol to get client ip addr instead of loadbalancer one
  # set {
  #   name  = "controller.config.use-proxy-protocol"
  #   value = "true"
  # }
  # set {
  #   name  = "controller.service.annotations.service\\.beta\\.kubernetes\\.io/scw-loadbalancer-proxy-protocol-v2"
  #   value = "true"
  # }
  # //monitoring-grafana
  set {
    name  = "controller.metrics.enabled"
    value = "true"
  }
  set {
    name  = "controller.podAnnotations.prometheus\\.io/scrape"
    value = "true"
    type  = "string"
  }
  set {
    name  = "controller.podAnnotations.prometheus\\.io/port"
    value = "10254"
    type  = "string"
  }
}

# resource "kubernetes_service" "ingress_nginx_controller_loadbalancer" {
#   metadata {
#     name      = "ingress-nginx-controller"
#     namespace = "ingress-nginx"
#   }
#   spec {
#     port {
#       name        = "http"
#       protocol    = "TCP"
#       port        = 80
#       target_port = "30080"
#       #node_port   = 80
#     }
#     port {
#       name        = "https"
#       protocol    = "TCP"
#       port        = 443
#       target_port = "30443"
#       #node_port   = 443
#     }
#     selector = {
#       "app.kubernetes.io/component" = "controller"
#       "app.kubernetes.io/instance"  = "ingress-nginx"
#       "app.kubernetes.io/name"      = "ingress-nginx"
#     }
#     type = "LoadBalancer"
#   }
# }

# resource "kubernetes_config_map" "ingress_nginx_controller" {
#   metadata {
#     name      = "ingress-nginx-controller"
#     namespace = "ingress-nginx"
#     labels = {
#       "app.kubernetes.io/component"  = "controller"
#       "app.kubernetes.io/instance"   = "ingress-nginx"
#       "app.kubernetes.io/managed-by" = "Helm"
#       "app.kubernetes.io/name"       = "ingress-nginx"
#       "app.kubernetes.io/part-of"    = "ingress-nginx"
#       "app.kubernetes.io/version"    = "1.1.1"
#       "helm.sh/chart"                = "ingress-nginx-4.0.16"
#     }
#   }
#   data = {
#     allow-snippet-annotations = "true"
#     enable-real-ip            = "true"
#     proxy-body-size           = "20m"
#     proxy-real-ip-cidr        = "0.0.0.0/0"
#     use-proxy-protocol        = "true"
#   }
# }
