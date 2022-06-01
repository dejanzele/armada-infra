resource "helm_release" "coredns" {
  name             = "coredns"
  repository       = "https://coredns.github.io/helm"
  chart            = "coredns"
  version          = "1.19.4"
  namespace        = "kube-system"

  depends_on = [module.system_managed_node_group]
}