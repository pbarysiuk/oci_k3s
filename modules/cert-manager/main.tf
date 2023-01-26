resource "helm_release" "cert_manager" {
  name             = "cert-manager"
  repository       = "https://charts.jetstack.io"
  chart            = "cert-manager"
  namespace        = "cert-manager"
  create_namespace = true

  set {
    name  = "installCRDs"
    value = "true"
  }
}

locals {
  cluster_issuer = {
    apiVersion = "cert-manager.io/v1"
    kind       = "ClusterIssuer"
    metadata = {
      name = "letsencrypt-staging"
    }
    spec = {
      acme = {
        # The ACME server URL
        server         = "https://acme-staging-v02.api.letsencrypt.org/directory"
        preferredChain = "ISRG Root X1"
        # Email address used for ACME registration
        email = "sh.holod@gmail.com"
        # Name of a secret used to store the ACME account private key
        privateKeySecretRef = {
          name = "letsencrypt-staging"
        }
        # Enable the HTTP-01 challenge provider
        solvers = [
          {
            "http01" = {
              "ingress" = {
                "class" = "nginx"
              }
            }
          }
        ]
      }
    }
  }
}

resource "kubectl_manifest" "cluster_issuer" {
  validate_schema = false
  yaml_body       = yamlencode(local.cluster_issuer)
}
# resource "kubernetes_manifest" "clusterissuer_letsencrypt_prod" {
#   depends_on = [data.cert_crd[0]]
#   manifest = {
#     "apiVersion" = "cert-manager.io/v1"
#     "kind" = "ClusterIssuer"
#     "metadata" = {
#       "name" = "letsencrypt-staging"
#     }
#     "spec" = {
#       "acme" = {
#         "email" = "sh.holod@gmail.com"
#         "privateKeySecretRef" = {
#           "name" = "letsencrypt-staging"
#         }
#         "server" = "https://acme-staging-v02.api.letsencrypt.org/directory"
#         "solvers" = [
#           {
#             "http01" = {
#               "ingress" = {
#                 "class" = "nginx"
#               }
#             }
#           },
#         ]
#       }
#     }
#   }
# }