resource "null_resource" "restart_coredns" {
  triggers = {
    run_when = local.k8s.cluster_name
  }

  provisioner "local-exec" {
    command = <<-EOT
      echo "Sleeping for 20s so Kubernetes nodes go into Ready state before coredns restart..."
      sleep 20
      kubectl rollout restart deployment coredns --context='${module.eks.cluster_arn}' --namespace kube-system
      echo "Waiting 15s for coredns pods to become operational..."
      sleep 15
    EOT

    interpreter = ["bash", "-c"]
  }

  depends_on = [module.system_managed_node_group, module.worker_managed_node_group]
}