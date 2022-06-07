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
      public_name   = "${upper(var.environment)}_PUBLIC_SUBNET"
      private_name  = "${upper(var.environment)}_PRIVATE_SUBNET"
      database_name = "${upper(var.environment)}_DATABASE_SUBNET"
    }
  }
  lt = {
    name = "${var.cluster_name}-lt"
  }

  k8s = {
    nvidia_device_plugin = {
      install = var.install_nvidia_device_plugin
    }
    calico = {
      install = var.install_calico_cni
    }
    additional_iam_policies = [
      "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy",
      "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy",
      "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly",
      "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
    ]
    ami      = "ami-09fff39455eafe6ab"
    key_pair = var.node_key_pair
    system_nodes = {
      create               = var.create_system_nodes
      taints               = var.system_node_taints
      bootstrap_extra_args = var.system_bootstrap_extra_args
      instance_types       = var.system_nodes_instance_types
      min_size             = var.system_nodes_min_size
      max_size             = var.system_nodes_max_size
      desired_size         = var.system_nodes_desired_size
    }
    worker_nodes = {
      create               = var.create_worker_nodes
      taints               = var.worker_node_taints
      bootstrap_extra_args = var.worker_bootstrap_extra_args
      instance_types       = var.worker_nodes_instance_types
      min_size             = var.worker_nodes_min_size
      max_size             = var.worker_nodes_max_size
      desired_size         = var.worker_nodes_desired_size
    }
    auth = {
      accounts = var.aws_auth_accounts
      users    = var.aws_auth_users
      roles    = var.aws_auth_roles
    }
    cluster_name = var.cluster_name
    api_version  = var.k8s_version
  }
}