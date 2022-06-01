resource "null_resource" "update_kubeconfig_with_cluster_info" {
  triggers = {
    run_when = local.k8s.cluster_name
  }

  provisioner "local-exec" {
    command = <<-EOT
      aws eks \
        --profile ${local.aws.profile} \
        --region ${local.aws.region} \
        update-kubeconfig \
        --name ${local.k8s.cluster_name}
    EOT
  }

  depends_on = [
    module.eks
  ]
}