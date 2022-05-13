terraform {
  backend "s3" {
    region         = "us-east-1"
    profile        = "armada"
    bucket         = "tfstate-oss"
    dynamodb_table = "tflock-oss"
    key            = "k8s/state.terraform"
  }
  required_version = "1.1.9"
}

provider "aws" {
  region  = local.aws.region
  profile = local.aws.profile
}

provider "kubernetes" {
  host                   = module.eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)

  exec {
    api_version = "client.authentication.k8s.io/v1alpha1"
    command     = "aws"
    # This requires the awscli to be installed locally where Terraform is executed
    args = ["eks", "get-token", "--cluster-name", module.eks.cluster_id, "--profile", local.aws.profile]
  }
}
