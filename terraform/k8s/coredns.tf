resource "helm_release" "coredns" {
  name       = "coredns"
  repository = "https://coredns.github.io/helm"
  chart      = "coredns"
  namespace  = "kube-system"
  verify     = false

  depends_on = [module.system_managed_node_group]
}