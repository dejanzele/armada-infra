data "aws_eks_cluster" "this" {
  name = module.k8s.cluster_name
}

data "aws_eks_cluster_auth" "aws_iam_authenticator" {
  name = data.aws_eks_cluster.this.name
}

provider "aws" {}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.this.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.this.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.aws_iam_authenticator.token
}

provider "helm" {
  kubernetes {
    host                   = data.aws_eks_cluster.this.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.this.certificate_authority[0].data)
    token                  = data.aws_eks_cluster_auth.aws_iam_authenticator.token
  }
}


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

  cluster_name  = "armada"
  eks_node_ami  = "ami-0df25b667dc8fb64d"
  node_key_pair = "dev-armada-debug"

  vpc_id                   = module.network.vpc_id
  control_plane_subnet_ids = module.network.vpc_public_subnets_ids
  worker_nodes_subnet_ids  = module.network.vpc_private_subnets_ids

  create_worker_nodes = true
}


module "addons" {
  source = "git::https://github.com/dejanzele/armada-infra.git//terraform/modules/addons"

  armada_domain = "dev.armadaproject.io"
  k8s_cluster   = module.k8s.cluster_name

  install_cert_manager              = true
  cert_manager_cluster_issuer_email = "service@armadaproject.io"
  install_metrics_server            = true
  install_prometheus                = true
  install_nginx_controller          = true
}
