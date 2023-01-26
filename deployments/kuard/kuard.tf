resource "kubernetes_deployment" "kuard" {
  metadata {
    name = "kuard"
  }
  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "kuard"
      }
    }
    template {
      metadata {
        labels = {
          app = "kuard"
        }
      }
      spec {
        container {
          name  = "kuard"
          image = "gcr.io/kuar-demo/kuard-arm:1"
          port {
            container_port = 8080
          }
          image_pull_policy = "Always"
        }
      }
    }
  }
}

resource "kubernetes_service" "kuard" {
  metadata {
    name = "kuard"
  }
  spec {
    port {
      protocol    = "TCP"
      port        = 80
      target_port = "8080"
    }
    selector = {
      app = "kuard"
    }
  }
}

resource "kubernetes_ingress_v1" "kuard" {
  metadata {
    name = "kuard"
    annotations = {
      "kubernetes.io/ingress.class" = "nginx"
      "cert-manager.io/issuer"      = "letsencrypt-staging"
    }
  }
  spec {
    tls {
      hosts       = ["example.my-demo-stand-showlabs.click"]
      secret_name = "quickstart-example-tls"
    }
    rule {
      host = "example.my-demo-stand-showlabs.click"
      http {
        path {
          path      = "/"
          path_type = "Prefix"
          backend {
            service {
              name = "kuard"
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