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
      kubectl --context='${module.eks.cluster_arn}' \
        apply -f https://docs.projectcalico.org/archive/v3.17/manifests/calico-vxlan.yaml
    EOT

    interpreter = ["bash", "-c"]
  }

  depends_on = [
    null_resource.remove_aws_vpc_cni,
    null_resource.update_kubeconfig_with_cluster_info,
    module.eks
  ]
}