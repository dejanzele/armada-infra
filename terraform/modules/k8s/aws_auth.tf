module "eks_auth" {
  source = "aidanmelen/eks-auth/aws"
  eks    = module.eks

  map_roles = concat(local.k8s.auth.roles, local.k8s.worker_nodes.create ? [
    {
      groups   = ["system:bootstrappers", "system:nodes"]
      rolearn  = module.system_managed_node_group[0].iam_role_arn
      username = "system:node:{{EC2PrivateDNSName}}"
    },
    {
      groups   = ["system:bootstrappers", "system:nodes"]
      rolearn  = module.worker_managed_node_group[0].iam_role_arn
      username = "system:node:{{EC2PrivateDNSName}}"
    }
    ] : [
    {
      groups   = ["system:bootstrappers", "system:nodes"]
      rolearn  = module.system_managed_node_group[0].iam_role_arn
      username = "system:node:{{EC2PrivateDNSName}}"
    }
  ])

  map_users = local.k8s.auth.users

  map_accounts = local.k8s.auth.accounts
}