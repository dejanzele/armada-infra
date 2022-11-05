data "aws_eks_cluster" "this" {
  name = module.k8s.cluster_name
}

data "aws_eks_cluster_auth" "aws_iam_authenticator" {
  name = data.aws_eks_cluster.this.name
}

provider "aws" {
  region = "us-east-1"
}

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

  vpc_name             = "armada"
  vpc_azs              = ["us-east-1a", "us-east-1b"]
  vpc_cidr             = "10.0.0.0/16"
  vpc_public_subnets   = ["10.0.0.0/20", "10.0.16.0/20"]
  vpc_private_subnets  = ["10.0.32.0/19", "10.0.64.0/19"]
  vpc_database_subnets = ["10.0.96.0/24", "10.0.97.0/24"]
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

  k8s_cluster = module.k8s.cluster_name

  install_cert_manager              = true
  cert_manager_cluster_issuer_email = "service@armadaproject.io"
  install_metrics_server            = true
  install_prometheus                = true
  install_nginx_controller          = true
}
