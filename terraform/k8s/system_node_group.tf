module "system_managed_node_group" {
  source = "terraform-aws-modules/eks/aws//modules/eks-managed-node-group"

  count = local.k8s.system_nodes.create ? 1 : 0

  name            = "${local.k8s.cluster_name}-system"
  cluster_name    = module.eks.cluster_id
  cluster_version = module.eks.cluster_version

  vpc_id                            = data.aws_vpc.vpc.id
  subnet_ids                        = data.aws_subnets.private.ids
  cluster_primary_security_group_id = module.eks.cluster_primary_security_group_id
  vpc_security_group_ids = [
    module.eks.cluster_security_group_id,
  ]

  iam_role_additional_policies = local.k8s.additional_iam_policies

  create_launch_template  = false

  ami_id = data.aws_ami.flatcar_pro_latest.image_id

  min_size     = local.k8s.system_nodes.min_size
  max_size     = local.k8s.system_nodes.max_size
  desired_size = local.k8s.system_nodes.desired_size

  instance_types = local.k8s.system_nodes.instance_types

  taints         = local.k8s.system_nodes.taints

  tags = {
    Name      = "${local.k8s.cluster_name}-worker"
    CalicoCNI = local.k8s.calico.install ? null_resource.install_calico_cni[0].id : false
  }
}