provider "aws" {}

module "network" {
  source = "git::https://github.com/dejanzele/armada-infra.git//terraform/modules/network"

  vpc_cidr             = "10.0.0.0/14"
  vpc_name             = "armada"
  vpc_azs              = ["us-east-1a", "us-east-1b"]
  vpc_public_subnets   = ["10.0.0.0/17", "10.0.128.0/17"]
  vpc_private_subnets  = ["10.1.0.0/17", "10.1.128.0/17"]
  vpc_database_subnets = ["10.2.0.0/17", "10.2.128.0/17"]
}

module "k8s" {
  source = "git::https://github.com/dejanzele/armada-infra.git//terraform/modules/k8s"
  cluster_name = "armada"
  eks_node_ami = "ami-0df25b667dc8fb64d"
  node_key_pair                = "dev-armada-debug"
  create_worker_nodes = true
  r53_zone = ""
  environment  = "dev"
}
