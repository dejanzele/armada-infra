resource "helm_release" "prometheus" {
  count = local.k8s.prometheus.install ? 1 : 0

  chart      = "kube-prometheus-stack"
  repository = "https://prometheus-community.github.io/helm-charts"
  name       = "kube-prometheus-stack"
  namespace  = kubernetes_namespace.gr_system.id

  values = [file("${path.module}/kube-prometheus-stack.values.yaml")]
}

resource "kubernetes_ingress_v1" "grafana_ingress" {
  count = local.k8s.grafana.create_ingress && local.aws.r53.domain != "" ? 1 : 0

  metadata {
    annotations = {
      "nginx.ingress.kubernetes.io/ssl-redirect" = "true"
      "certmanager.k8s.io/cluster-issuer"        = local.k8s.cert_manager.cluster_issuer
      "cert-manager.io/cluster-issuer"           = local.k8s.cert_manager.cluster_issuer
    }
    labels = {
      "kubernetes.io/ingress.class" = "nginx"
    }
    name      = "kube-prometheus-stack-grafana-ingress"
    namespace = kubernetes_namespace.gr_system.id
  }

  spec {
    ingress_class_name = "nginx"
    rule {
      host = "dashboard.${data.aws_route53_zone.this[0].name}"
      http {
        path {
          backend {
            service {
              name = "kube-prometheus-stack-grafana"
              port {
                number = 80
              }
            }
          }
          path_type = "Prefix"
          path      = "/"
        }
      }
    }

    tls {
      hosts       = ["dashboard.${data.aws_route53_zone.this[0].name}"]
      secret_name = "grafana-tls"
    }
  }

  depends_on = [helm_release.prometheus]
}

provider "grafana" {
  url  = "https://dashboard.${local.aws.r53.domain}"
  auth = local.k8s.grafana.auth
}

resource "grafana_data_source" "cluster_0" {
  count = local.k8s.grafana.create_ingress && local.k8s.grafana.init ? 1 : 0
  type  = "prometheus"
  name  = "cluster-0"
  url   = "http://kube-prometheus-stack-prometheus.${kubernetes_namespace.gr_system.id}.svc.cluster.local:9090"

  depends_on = [kubernetes_ingress_v1.grafana_ingress]
}

resource "grafana_dashboard" "metrics" {
  count = local.k8s.grafana.create_ingress && local.k8s.grafana.init ? 1 : 0

  config_json = file("${path.module}/dashboards/grafana-armada-dashboard.json")

  depends_on = [kubernetes_ingress_v1.grafana_ingress]
}
