terraform {
  backend "s3" {
    region         = "us-east-1"
    profile        = "armada"
    bucket         = "tfstate-oss"
    dynamodb_table = "tflock-oss"
    key            = "addons/state.terraform"
  }
  required_version = "1.1.9"
}

provider "aws" {
  region  = local.aws.region
  profile = local.aws.profile
}

provider "helm" {
  kubernetes {
    host                   = data.aws_eks_cluster.this.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.this.certificate_authority[0].data)
    token                  = data.aws_eks_cluster_auth.aws_iam_authenticator.token
  }
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.this.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.this.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.aws_iam_authenticator.token
}
