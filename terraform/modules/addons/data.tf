data "aws_caller_identity" "this" {}

data "aws_eks_cluster" "this" {
  name = local.k8s.cluster
}

data "aws_eks_cluster_auth" "aws_iam_authenticator" {
  name = data.aws_eks_cluster.this.name
}

data "aws_route53_zone" "this" {
  name = local.aws.r53.domain
}