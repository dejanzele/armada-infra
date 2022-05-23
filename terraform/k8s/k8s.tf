module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 18.0"

  cluster_name    = local.k8s.cluster_name
  cluster_version = local.k8s.api_version

  cluster_endpoint_private_access = true
  cluster_endpoint_public_access  = true

  cluster_addons = {
    coredns = {
      resolve_conflicts = "OVERWRITE"
    }
    kube-proxy = {}
    vpc-cni = {
      resolve_conflicts = "OVERWRITE"
    }
  }

  vpc_id     = data.aws_vpc.vpc.id
  subnet_ids = data.aws_subnets.public.ids

  # EKS Managed Node Group(s)
  eks_managed_node_group_defaults = {
    disk_size      = 50
    instance_types = ["t4g.large"]
  }

  eks_managed_node_groups = {
    bottlerocket = {
      name            = "${local.k8s.cluster_name}-worker"

      create_launch_template = false
      launch_template_name   = ""

      ami_type = "BOTTLEROCKET_x86_64"
      platform = "bottlerocket"

      subnet_ids = data.aws_subnets.private.ids
      min_size     = 3
      max_size     = 5
      desired_size = 4

      instance_types = ["t3.large"]
      capacity_type  = "SPOT"

      tags = {
        Name = "${local.k8s.cluster_name}-worker"
      }
    }
  }

  # aws-auth configmap
  manage_aws_auth_configmap = true

  aws_auth_users = local.k8s.auth.users
  aws_auth_roles = local.k8s.auth.roles
  aws_auth_accounts = local.k8s.auth.accounts

  tags = {
    Cluster     = local.k8s.cluster_name
    Environment = local.environment
    Terraform   = "true"
  }
}