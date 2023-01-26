resource "helm_release" "prometheus" {
  chart            = "kube-prometheus-stack"
  name             = "prometheus"
  repository       = "https://prometheus-community.github.io/helm-charts"
  namespace        = "monitoring"
  create_namespace = true
  #version    = "15.5.3"
  values = [file("${path.module}/config.yaml")]
  set {
    name  = "grafana.ingress.enabled"
    value = "true"
  }
  set {
    name  = "grafana.ingress.ingressClassName"
    value = "nginx"
  }
  set {
    name  = "grafana.ingress.path"
    value = "/grafana/(.*)" # "/grafana2/?(.*)"
  }
  # annotations:
  #   nginx.ingress.kubernetes.io/ssl-redirect: "false"
  #   nginx.ingress.kubernetes.io/use-regex: "true"
  #   nginx.ingress.kubernetes.io/rewrite-target: /$1
  set {
    name  = "grafana.ingress.annotations.nginx\\.ingress\\.kubernetes\\.io/ssl-redirect"
    value = "false"
    type  = "string"
  }
  set {
    name  = "grafana.ingress.annotations.nginx\\.ingress\\.kubernetes\\.io/use-regex"
    value = "true"
    type  = "string"
  }
  set {
    name  = "grafana.ingress.annotations.nginx\\.ingress\\.kubernetes\\.io/rewrite-target"
    value = "/$1"
  }
  # set {
  #   name  = "'grafana\\.ini'.server.root_url"
  #   value = "http://my-demo-stand-showlabs.click/grafana"
  # }

  set {
    name  = "podSecurityPolicy.enabled"
    value = true
  }

  set {
    name  = "server.persistentVolume.enabled"
    value = false
  }

  # You can provide a map of value using yamlencode. Don't forget to escape the last element after point in the name
  set {
    name = "server\\.resources"
    value = yamlencode({
      limits = {
        cpu    = "200m"
        memory = "50Mi"
      }
      requests = {
        cpu    = "100m"
        memory = "30Mi"
      }
    })
  }
}

