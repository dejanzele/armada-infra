module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 18.0"

  cluster_name    = local.k8s.cluster_name
  cluster_version = local.k8s.api_version

  cluster_endpoint_private_access = true
  cluster_endpoint_public_access  = true

  cluster_addons = {
    kube-proxy = {}
  }

  iam_role_additional_policies = local.k8s.defaults.additional_iam_policies

  vpc_id     = data.aws_vpc.vpc.id
  subnet_ids = data.aws_subnets.public.ids

  # EKS Managed Node Group(s)
  eks_managed_node_group_defaults = {
    disk_size                    = 50
    instance_types               = local.k8s.defaults.instance_types
    iam_role_additional_policies = local.k8s.defaults.additional_iam_policies
  }

  # aws-auth configmap
  manage_aws_auth_configmap = false
  create_aws_auth_configmap = false

  aws_auth_users    = local.k8s.auth.users
  aws_auth_roles    = local.k8s.auth.roles
  aws_auth_accounts = local.k8s.auth.accounts

  tags = {
    Cluster     = local.k8s.cluster_name
    Environment = local.environment
    Terraform   = "true"
  }
}