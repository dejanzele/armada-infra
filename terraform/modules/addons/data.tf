data "aws_caller_identity" "this" {}

data "aws_route53_zone" "this" {
  count = local.aws.r53.domain != "" ? 1 : 0

  name = local.aws.r53.domain
}

data "aws_eks_cluster" "this" {
  name = local.k8s.cluster
}
