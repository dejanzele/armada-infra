resource "helm_release" "gpu_operator" {
  count = local.k8s.gpu_operator.install ? 1 : 0

  chart            = "gpu-operator"
  repository       = "https://nvidia.github.io/gpu-operator"
  name             = "gpu-operator"
  namespace        = "gpu-operator"
  create_namespace = true
}