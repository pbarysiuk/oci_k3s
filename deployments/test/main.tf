resource "kubernetes_service" "frontend_saas" {
  metadata {
    name = "svc-${var.environment}-${var.name}"
    #namespace = "echo"
  }
  spec {
    port {
      port        = 80
      target_port = "80"
    }
    selector = {
      app = "app-${var.environment}-${var.name}"
    }
  }
}

resource "kubernetes_deployment" "frontend_saas" {
  metadata {
    name = "app-${var.environment}-${var.name}"
    #namespace = "echo"
  }
  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "app-${var.environment}-${var.name}"
      }
    }
    template {
      metadata {
        labels = {
          app  = "app-${var.environment}-${var.name}"
          tier = "frontend"
          env  = var.environment
        }
      }
      spec {
        container {
          name  = var.name
          image = "ealen/echo-server"
          #args  = ["someagr_here"]
          port {
            container_port = 80
          }
        }
      }
    }
  }
}

resource "kubernetes_ingress_v1" "frontend_backoffice" {
  metadata {
    name = "${var.environment}-${var.name}-ingress"
    annotations = {
      #"cert-manager.io/issuer" = "node-express-kubernetes-example-letsencrypt-dev"
      "kubernetes.io/ingress.class" = "nginx"
    }
  }
  spec {
    # tls {
    #   hosts       = ["node-example.juffalow.com"]
    #   secret_name = "node-express-kubernetes-example-tls"
    # }
    rule {
      host = "my-demo-stand-showlabs.click"
      http {
        path {
          path      = "/"
          path_type = "Prefix"
          backend {
            service {
              name = kubernetes_service.frontend_saas.metadata[0].name
              port {
                number = 80
              }
            }
          }
        }
      }
    }
  }
}