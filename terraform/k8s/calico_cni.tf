resource "null_resource" "remove_aws_vpc_cni" {
  count = local.k8s.calico.install ? 1 : 0

  triggers = {
    run_when = local.k8s.cluster_name
  }

  provisioner "local-exec" {
    command = <<-EOT
      kubectl delete daemonset --context='${module.eks.cluster_arn}' --namespace kube-system aws-node
    EOT

    interpreter = ["bash", "-c"]
  }

  depends_on = [
    module.eks,
    null_resource.update_kubeconfig_with_cluster_info
  ]
}

resource "null_resource" "install_calico_cni" {
  count = local.k8s.calico.install ? 1 : 0

  triggers = {
    run_when = local.k8s.cluster_name
  }

  provisioner "local-exec" {
    command = <<-EOT
      kubectl --context='${module.eks.cluster_arn}' create -f https://projectcalico.docs.tigera.io/manifests/tigera-operator.yaml
      kubectl create -f - <<EOF
kind: Installation
apiVersion: operator.tigera.io/v1
metadata:
  name: default
spec:
  kubernetesProvider: EKS
  cni:
    type: Calico
  calicoNetwork:
    bgp: Disabled
EOF
    EOT

    interpreter = ["bash", "-c"]
  }

  depends_on = [
    null_resource.remove_aws_vpc_cni,
    null_resource.update_kubeconfig_with_cluster_info,
    module.eks
  ]
}

resource "null_resource" "validate_aws_cni_deleted" {
  count = local.k8s.calico.install ? 1 : 0

  triggers = {
    run_when = local.k8s.cluster_name
  }

  provisioner "local-exec" {
    command = <<-EOT
      kubectl delete daemonset --context='${module.eks.cluster_arn}' --namespace kube-system aws-node || true
    EOT

    interpreter = ["bash", "-c"]
  }

  depends_on = [
    module.system_managed_node_group,
    module.worker_managed_node_group
  ]
}
