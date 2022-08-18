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
    prometheus = {
      install = var.install_prometheus
    }
    metrics_server = {
      install = var.install_metrics_server
    }
    external_dns = {
      service_account = "external-dns"
      namespace       = "kube-system"
    }
    alb_controller = {
      namespace = "kube-system"
    }
    cert_manager = {
      install   = var.install_cert_manager
      email     = var.cert_manager_cluster_issuer_email
      namespace = "cert-manager"
    }
    type    = "eks"
    cluster = var.k8s_cluster
  }
}