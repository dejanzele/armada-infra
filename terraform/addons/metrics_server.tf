resource "helm_release" "metrics_server" {
  count = local.k8s.metrics_server.install ? 1 : 0

  chart      = "metrics-server"
  repository = "https://kubernetes-sigs.github.io/metrics-server/"
  name       = "metrics-server"
  namespace  = "kube-system"
}