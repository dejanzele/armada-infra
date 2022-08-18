resource "helm_release" "nvidia_device_plugin" {
  count = local.k8s.nvidia_device_plugin.install ? 1 : 0

  name             = "nvdp"
  repository       = "https://nvidia.github.io/k8s-device-plugin"
  chart            = "nvidia-device-plugin"
  version          = "0.12.0"
  namespace        = "gpu-operator"
  create_namespace = true
  values = [file("nvidia.values.yaml")]

  depends_on = [null_resource.restart_coredns]
}