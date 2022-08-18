resource "helm_release" "prometheus" {
  count = local.k8s.prometheus.install ? 1 : 0

  chart      = "kube-prometheus-stack"
  repository = "https://prometheus-community.github.io/helm-charts"
  name       = "kube-prometheus-stack"
  namespace  = kubernetes_namespace.gr_system.id
}