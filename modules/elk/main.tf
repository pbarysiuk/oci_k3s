resource "helm_release" "elk" {
  name       = "elk"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "elasticsearch"
  #version          = var.chart_version
  namespace        = "elk"
  create_namespace = true
}