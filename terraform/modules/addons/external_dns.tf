resource "helm_release" "external-dns" {
  name       = "external-dns"
  namespace  = local.k8s.external_dns.namespace
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "external-dns"
  version    = "6.5.6"

  set {
    name  = "serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
    value = aws_iam_role.external_dns.arn
  }

  set {
    name  = "serviceAccount.name"
    value = local.k8s.external_dns.service_account
  }

  set {
    name  = "zoneType"
    value = "public"
  }

  set {
    name  = "annotationFilter"
    value = "kubernetes\\.io/ingress\\.class=nginx"
  }

  set {
    name  = "domainFilters[0]"
    value = local.aws.r53.domain
  }

  set {
    name  = "provider"
    value = "aws"
  }

  set {
    name  = "txtOwnerId" # TXT record identifier
    value = "external-dns-armada"
  }
}

resource "aws_iam_role" "external_dns" {
  name = "external-dns-${local.environment}-armada"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Federated": "arn:aws:iam::${data.aws_caller_identity.this.account_id}:oidc-provider/${replace(data.aws_eks_cluster.this.identity[0].oidc[0].issuer, "https://", "")}"
      },
      "Action": "sts:AssumeRoleWithWebIdentity",
      "Condition": {
        "StringEquals": {
          "${replace(data.aws_eks_cluster.this.identity[0].oidc[0].issuer, "https://", "")}:sub": "system:serviceaccount:${local.k8s.external_dns.namespace}:${local.k8s.external_dns.service_account}"
        }
      }
    }
  ]
}
  EOF
  tags = {
    Terraform = "true"
  }
}

resource "aws_iam_role_policy_attachment" "external_dns" {
  role       = aws_iam_role.external_dns.name
  policy_arn = aws_iam_policy.external_dns.arn
}

resource "aws_iam_policy" "external_dns" {
  name        = "external-dns-${var.environment}-armada"
  description = "Policy using OIDC to give the EKS external dns ServiceAccount permissions to update Route53"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
  {
     "Effect": "Allow",
     "Action": [
       "route53:ChangeResourceRecordSets"
     ],
     "Resource": [
       "arn:aws:route53:::hostedzone/*"
     ]
   },
   {
     "Effect": "Allow",
     "Action": [
       "route53:ListHostedZones",
       "route53:ListResourceRecordSets"
     ],
     "Resource": [
       "*"
     ]
   }
  ]
}
EOF
}
