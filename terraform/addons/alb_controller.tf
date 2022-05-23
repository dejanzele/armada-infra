module "alb_ingress_controller" {
  source  = "iplabs/alb-ingress-controller/kubernetes"
  version = "3.1.0"

  k8s_cluster_type = local.k8s.type
  k8s_namespace    = local.k8s.alb_controller.namespace

  aws_region_name  = local.aws.region
  k8s_cluster_name = data.aws_eks_cluster.this.name
}
