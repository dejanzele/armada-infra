locals {
  environment = var.environment
  aws = {
    region  = var.aws_region
    profile = var.aws_profile
  }
  vpc = {
    name = "${upper(local.environment)}_VPC"
    cidr = var.vpc_cidr
    azs  = var.vpc_azs
    subnets = {
      public_cidrs   = var.vpc_public_subnets
      public_name    = "${upper(local.environment)}_PUBLIC_SUBNET"
      private_cidrs  = var.vpc_private_subnets
      private_name   = "${upper(local.environment)}_PRIVATE_SUBNET"
      database_cidrs = var.vpc_database_subnets
      database_name  = "${upper(local.environment)}_DATABASE_SUBNET"
    }
  }
}