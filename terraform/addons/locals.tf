locals {
  environment = var.environment
  aws = {
    region  = var.aws_region
    profile = var.aws_profile
    r53 = {
      domain = var.armada_domain
    }
  }
  k8s = {
    gpu_operator = {
      install = var.install_gpu_operator
    }
    prometheus = {
      install = var.install_prometheus
    }
    external_dns = {
      service_account = "external-dns"
      namespace       = "kube-system"
    }
    alb_controller = {
      namespace = "kube-system"
    }
    cert_manager = {
      email     = var.cert_manager_cluster_issuer_email
      namespace = "cert-manager"
    }
    type    = "eks"
    cluster = var.k8s_cluster
  }
}