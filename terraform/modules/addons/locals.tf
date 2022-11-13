locals {
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
    nginx_controller = {
      install = var.install_nginx_controller
    }
    external_dns = {
      service_account = "external-dns"
      namespace       = "kube-system"
    }
    alb_controller = {
      namespace = "kube-system"
    }
    cert_manager = {
      install        = var.install_cert_manager
      email          = var.cert_manager_cluster_issuer_email
      cluster_issuer = var.cert_manager_cluster_issuer
      namespace      = "cert-manager"
    }
    grafana = {
      create_ingress = var.grafana_create_ingress
      init           = var.grafana_init
      auth           = var.grafana_auth
    }
    type    = "eks"
    cluster = var.k8s_cluster
  }
}
