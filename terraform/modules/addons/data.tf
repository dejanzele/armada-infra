data "aws_caller_identity" "this" {}

data "aws_route53_zone" "this" {
  name = local.aws.r53.domain
}
