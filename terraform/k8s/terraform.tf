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