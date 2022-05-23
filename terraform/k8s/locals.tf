locals {
  environment = var.environment
  aws = {
    region  = var.aws_region
    profile = var.aws_profile
  }
  dns = {
    zone = var.r53_zone
  }
  vpc = {
    name = "${upper(var.environment)}_VPC"
    subnets = {
      public_name = "${upper(var.environment)}_PUBLIC_SUBNET"
      private_name = "${upper(var.environment)}_PRIVATE_SUBNET"
      database_name = "${upper(var.environment)}_DATABASE_SUBNET"
    }
  }
  k8s = {
    auth = {
      accounts = var.aws_auth_accounts
      users    = var.aws_auth_users
      roles    = var.aws_auth_roles
    }
    cluster_name = var.cluster_name
    api_version  = var.k8s_version
  }
}