provider "aws" {
  region = "us-east-1"
}

module "network" {
  source = "git::https://github.com/dejanzele/armada-infra.git//terraform/modules/network"

  vpc_name             = "armada"
  vpc_azs              = ["us-east-1a", "us-east-1b"]
  vpc_cidr             = "10.0.0.0/16"
  vpc_public_subnets   = ["10.0.0.0/20", "10.0.16.0/20"]
  vpc_private_subnets  = ["10.0.32.0/19", "10.0.64.0/19"]
  vpc_database_subnets = ["10.0.96.0/24", "10.0.97.0/24"]
}
