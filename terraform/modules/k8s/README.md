<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |
| <a name="provider_helm"></a> [helm](#provider\_helm) | n/a |
| <a name="provider_null"></a> [null](#provider\_null) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_ebs_csi_eks_role"></a> [ebs\_csi\_eks\_role](#module\_ebs\_csi\_eks\_role) | terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks | n/a |
| <a name="module_eks"></a> [eks](#module\_eks) | terraform-aws-modules/eks/aws | ~> 18.0 |
| <a name="module_eks_auth"></a> [eks\_auth](#module\_eks\_auth) | aidanmelen/eks-auth/aws | n/a |
| <a name="module_system_managed_node_group"></a> [system\_managed\_node\_group](#module\_system\_managed\_node\_group) | terraform-aws-modules/eks/aws//modules/eks-managed-node-group | n/a |
| <a name="module_worker_managed_node_group"></a> [worker\_managed\_node\_group](#module\_worker\_managed\_node\_group) | terraform-aws-modules/eks/aws//modules/eks-managed-node-group | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_launch_template.launch_template](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/launch_template) | resource |
| [helm_release.ebs_csi_driver](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [helm_release.nvidia_device_plugin](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [null_resource.install_calico_cni](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.remove_aws_vpc_cni](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.restart_coredns](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.update_kubeconfig_with_cluster_info](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.validate_aws_cni_deleted](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [aws_ami.flatcar_pro_latest](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) | data source |
| [aws_route53_zone.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route53_zone) | data source |
| [aws_subnets.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnets) | data source |
| [aws_subnets.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnets) | data source |
| [aws_vpc.vpc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_additional_role"></a> [aws\_additional\_role](#input\_aws\_additional\_role) | Additional IAM role to add in aws-auth configmap | `string` | `""` | no |
| <a name="input_aws_auth_accounts"></a> [aws\_auth\_accounts](#input\_aws\_auth\_accounts) | List of AWS accounts to grant access to the cluster | `list(string)` | `[]` | no |
| <a name="input_aws_auth_roles"></a> [aws\_auth\_roles](#input\_aws\_auth\_roles) | List of IAM roles to grant access to the cluster | `list(object({ rolearn = string, username = string, groups = list(string) }))` | `[]` | no |
| <a name="input_aws_auth_users"></a> [aws\_auth\_users](#input\_aws\_auth\_users) | List of IAM users to grant access to the cluster | `list(object({ userarn = string, username = string, groups = list(string) }))` | `[]` | no |
| <a name="input_aws_profile"></a> [aws\_profile](#input\_aws\_profile) | AWS Profile | `string` | `"armada"` | no |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS Region | `string` | `"us-east-1"` | no |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | K8s cluster name | `string` | n/a | yes |
| <a name="input_create_system_nodes"></a> [create\_system\_nodes](#input\_create\_system\_nodes) | Toggle should create managed node group for system nodes | `bool` | `true` | no |
| <a name="input_create_worker_nodes"></a> [create\_worker\_nodes](#input\_create\_worker\_nodes) | Toggle should create managed node group for worker nodes | `bool` | `false` | no |
| <a name="input_eks_node_ami"></a> [eks\_node\_ami](#input\_eks\_node\_ami) | AMI for k8s nodes | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment (dev, qa, prod...) | `string` | n/a | yes |
| <a name="input_flatcar_channel"></a> [flatcar\_channel](#input\_flatcar\_channel) | Flatcar channel to deploy on instances | `string` | `"stable"` | no |
| <a name="input_install_calico_cni"></a> [install\_calico\_cni](#input\_install\_calico\_cni) | Toggle whether to install Calico CNI | `bool` | `true` | no |
| <a name="input_install_nvidia_device_plugin"></a> [install\_nvidia\_device\_plugin](#input\_install\_nvidia\_device\_plugin) | Toggle whether to install NVIDIA Device Plugin | `bool` | `false` | no |
| <a name="input_k8s_version"></a> [k8s\_version](#input\_k8s\_version) | K8s API version | `string` | `"1.21"` | no |
| <a name="input_node_key_pair"></a> [node\_key\_pair](#input\_node\_key\_pair) | Key Pair to SSH into worker/system nodes | `string` | `null` | no |
| <a name="input_r53_zone"></a> [r53\_zone](#input\_r53\_zone) | Armada hosted zone | `string` | `"dev.armadaproject.io"` | no |
| <a name="input_system_node_labels"></a> [system\_node\_labels](#input\_system\_node\_labels) | System node labels | `map(string)` | `{}` | no |
| <a name="input_system_node_taints"></a> [system\_node\_taints](#input\_system\_node\_taints) | System node taints | `list(object({ key = string, value = string, effect = string }))` | `[]` | no |
| <a name="input_system_nodes_desired_size"></a> [system\_nodes\_desired\_size](#input\_system\_nodes\_desired\_size) | System Node Group desired size | `number` | `3` | no |
| <a name="input_system_nodes_instance_types"></a> [system\_nodes\_instance\_types](#input\_system\_nodes\_instance\_types) | Managed node group instance type | `list(string)` | <pre>[<br>  "t3.medium"<br>]</pre> | no |
| <a name="input_system_nodes_max_size"></a> [system\_nodes\_max\_size](#input\_system\_nodes\_max\_size) | System Node Group max size | `number` | `5` | no |
| <a name="input_system_nodes_min_size"></a> [system\_nodes\_min\_size](#input\_system\_nodes\_min\_size) | System Node Group min size | `number` | `2` | no |
| <a name="input_worker_node_labels"></a> [worker\_node\_labels](#input\_worker\_node\_labels) | Node labels | `map(string)` | `{}` | no |
| <a name="input_worker_node_taints"></a> [worker\_node\_taints](#input\_worker\_node\_taints) | Node taints | `list(object({ key = string, value = string, effect = string }))` | `[]` | no |
| <a name="input_worker_nodes_desired_size"></a> [worker\_nodes\_desired\_size](#input\_worker\_nodes\_desired\_size) | Worker Node Group desired size | `number` | `3` | no |
| <a name="input_worker_nodes_instance_types"></a> [worker\_nodes\_instance\_types](#input\_worker\_nodes\_instance\_types) | Managed node group instance type | `list(string)` | <pre>[<br>  "t3.medium"<br>]</pre> | no |
| <a name="input_worker_nodes_max_size"></a> [worker\_nodes\_max\_size](#input\_worker\_nodes\_max\_size) | Worker Node Group max size | `number` | `5` | no |
| <a name="input_worker_nodes_min_size"></a> [worker\_nodes\_min\_size](#input\_worker\_nodes\_min\_size) | Worker Node Group min size | `number` | `2` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->