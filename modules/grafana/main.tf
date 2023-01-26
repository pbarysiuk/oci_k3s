resource "helm_release" "grafana" {
  chart      = "grafana"
  name       = "grafana"
  repository = "https://grafana.github.io/helm-charts"
  namespace  = "monitoring"
  #version    = "6.24.1"
  set {
    name  = "grafana.rbac.pspEnabled"
    value = "false"
  }
}