locals {
  aws = {
    region  = var.aws_region
    profile = var.aws_profile
  }
  vpc = {
    id                       = var.vpc_id
    control_plane_subnet_ids = var.control_plane_subnet_ids
    worker_nodes_subnet_ids  = var.worker_nodes_subnet_ids
  }
  lt = {
    name = "${var.cluster_name}-lt"
  }

  k8s = {
    defaults = {
      instance_types = ["t3.medium"]
      additional_iam_policies = [
        "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy",
        "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy",
        "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly",
        "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
      ]
    }
    node_max_pods = 100
    nvidia_device_plugin = {
      install = var.install_nvidia_device_plugin
    }
    calico = {
      install = var.install_calico_cni
    }
    ami      = var.eks_node_ami
    key_pair = var.node_key_pair
    system_nodes = {
      create         = var.create_system_nodes
      taints         = var.system_node_taints
      labels         = var.system_node_labels
      instance_types = var.system_nodes_instance_types
      min_size       = var.system_nodes_min_size
      max_size       = var.system_nodes_max_size
      desired_size   = var.system_nodes_desired_size
    }
    worker_nodes = {
      create         = var.create_worker_nodes
      taints         = var.worker_nodes_taints
      labels         = var.worker_nodes_labels
      instance_types = var.worker_nodes_instance_types
      min_size       = var.worker_nodes_min_size
      max_size       = var.worker_nodes_max_size
      desired_size   = var.worker_nodes_desired_size
    }
    auth = {
      accounts = var.aws_auth_accounts
      users    = var.aws_auth_users
      roles    = var.aws_auth_roles
    }
    cluster_name    = var.cluster_name
    additional_tags = var.additional_tags
  }
}
