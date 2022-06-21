resource "null_resource" "restart_coredns" {
  triggers = {
    run_when = local.k8s.cluster_name
  }

  provisioner "local-exec" {
    command = <<-EOT
      kubectl rollout restart deployment coredns --context='${module.eks.cluster_arn}' --namespace kube-system
    EOT

    interpreter = ["bash", "-c"]
  }

  depends_on = [module.system_managed_node_group]
}