resource "helm_release" "cert_manager" {
  name             = "cert-manager"
  repository       = "https://charts.jetstack.io"
  chart            = "cert-manager"
  version          = "1.8.0"
  namespace        = local.k8s.cert_manager.namespace
  create_namespace = true

  set {
    name  = "serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
    value = module.cert_manager_irsa.this_iam_role_arn
  }

  set {
    name  = "installCRDs"
    value = "true"
  }
}

resource "helm_release" "cert_manager_cluster_issuer" {
  name      = "cert-manager-cluster-issuer"
  chart     = "${path.module}/charts/clusterissuer"
  namespace = local.k8s.cert_manager.namespace

  set {
    name  = "email"
    value = local.k8s.cert_manager.email
  }

  set {
    name  = "route53.region"
    value = local.aws.region
  }

  set {
    name  = "route53.hostedZoneID"
    value = data.aws_route53_zone.this.zone_id
  }

  depends_on = [helm_release.cert_manager]
}

module "cert_manager_irsa" {
  source                        = "terraform-aws-modules/iam/aws//modules/iam-assumable-role-with-oidc"
  version                       = "3.6.0"
  create_role                   = true
  role_name                     = "${local.environment}-armada-cert_manager-irsa"
  provider_url                  = replace(data.aws_eks_cluster.this.identity[0].oidc[0].issuer, "https://", "")
  role_policy_arns              = [aws_iam_policy.cert_manager_policy.arn]
  oidc_fully_qualified_subjects = ["system:serviceaccount:cert-manager:cert-manager"]
}

resource "aws_iam_policy" "cert_manager_policy" {
  name        = "${local.environment}-armada-cert-manager-policy"
  path        = "/"
  description = "Policy, which allows CertManager to create Route53 records"

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : "route53:GetChange",
        "Resource" : "arn:aws:route53:::change/*"
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "route53:ChangeResourceRecordSets",
          "route53:ListResourceRecordSets"
        ],
        "Resource" : "arn:aws:route53:::hostedzone/${data.aws_route53_zone.this.zone_id}"
      },
    ]
  })
}