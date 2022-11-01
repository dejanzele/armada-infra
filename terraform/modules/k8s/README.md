<!-- BEGIN_TF_DOCS -->
## Terraform module - k8s

This module creates a Kubernetes cluster in an AWS VPC.

This module is recommended to be used with [network](https://github.com/dejanzele/armada-infra/tree/main/terraform/modules/network)
Terraform module.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.37.0 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | >= 2.7.1 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | >= 2.15.0 |

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

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | K8s cluster name | `string` | n/a | yes |
| <a name="input_control_plane_subnet_ids"></a> [control\_plane\_subnet\_ids](#input\_control\_plane\_subnet\_ids) | List of VPC Subnet IDs in which to provision the k8s control plane | `list(string)` | n/a | yes |
| <a name="input_node_key_pair"></a> [node\_key\_pair](#input\_node\_key\_pair) | Key Pair to SSH into worker/system nodes | `string` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | VPC ID in which to provision the k8s cluster | `string` | n/a | yes |
| <a name="input_worker_nodes_subnet_ids"></a> [worker\_nodes\_subnet\_ids](#input\_worker\_nodes\_subnet\_ids) | List of VPC Subnet IDs in which to provision the k8s worker nodes | `list(string)` | n/a | yes |
| <a name="input_additional_tags"></a> [additional\_tags](#input\_additional\_tags) | Additional tags to apply to resources | `any` | `{}` | no |
| <a name="input_aws_additional_role"></a> [aws\_additional\_role](#input\_aws\_additional\_role) | Additional IAM role to add in aws-auth configmap | `string` | `""` | no |
| <a name="input_aws_auth_accounts"></a> [aws\_auth\_accounts](#input\_aws\_auth\_accounts) | List of AWS accounts to grant access to the cluster | `list(string)` | `[]` | no |
| <a name="input_aws_auth_roles"></a> [aws\_auth\_roles](#input\_aws\_auth\_roles) | List of IAM roles to grant access to the cluster | `list(object({ rolearn = string, username = string, groups = list(string) }))` | `[]` | no |
| <a name="input_aws_auth_users"></a> [aws\_auth\_users](#input\_aws\_auth\_users) | List of IAM users to grant access to the cluster | `list(object({ userarn = string, username = string, groups = list(string) }))` | `[]` | no |
| <a name="input_aws_profile"></a> [aws\_profile](#input\_aws\_profile) | AWS Profile | `string` | `""` | no |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS Region | `string` | `"us-east-1"` | no |
| <a name="input_create_system_nodes"></a> [create\_system\_nodes](#input\_create\_system\_nodes) | Toggle should create managed node group for system nodes | `bool` | `true` | no |
| <a name="input_create_worker_nodes"></a> [create\_worker\_nodes](#input\_create\_worker\_nodes) | Toggle should create managed node group for worker nodes | `bool` | `false` | no |
| <a name="input_eks_node_ami"></a> [eks\_node\_ami](#input\_eks\_node\_ami) | AMI for k8s nodes (default is for k8s v1.23 in us-east-1 region) | `string` | `"ami-0df25b667dc8fb64d"` | no |
| <a name="input_install_calico_cni"></a> [install\_calico\_cni](#input\_install\_calico\_cni) | Toggle whether to install Calico CNI | `bool` | `false` | no |
| <a name="input_install_nvidia_device_plugin"></a> [install\_nvidia\_device\_plugin](#input\_install\_nvidia\_device\_plugin) | Toggle whether to install NVIDIA Device Plugin | `bool` | `false` | no |
| <a name="input_system_node_labels"></a> [system\_node\_labels](#input\_system\_node\_labels) | System node labels | `map(string)` | `{}` | no |
| <a name="input_system_node_taints"></a> [system\_node\_taints](#input\_system\_node\_taints) | System node taints | `list(object({ key = string, value = string, effect = string }))` | `[]` | no |
| <a name="input_system_nodes_desired_size"></a> [system\_nodes\_desired\_size](#input\_system\_nodes\_desired\_size) | System Node Group desired size | `number` | `3` | no |
| <a name="input_system_nodes_instance_types"></a> [system\_nodes\_instance\_types](#input\_system\_nodes\_instance\_types) | Managed node group instance type | `list(string)` | <pre>[<br>  "t3.medium"<br>]</pre> | no |
| <a name="input_system_nodes_max_size"></a> [system\_nodes\_max\_size](#input\_system\_nodes\_max\_size) | System Node Group max size | `number` | `5` | no |
| <a name="input_system_nodes_min_size"></a> [system\_nodes\_min\_size](#input\_system\_nodes\_min\_size) | System Node Group min size | `number` | `2` | no |
| <a name="input_worker_nodes_desired_size"></a> [worker\_nodes\_desired\_size](#input\_worker\_nodes\_desired\_size) | Worker Node Group desired size | `number` | `3` | no |
| <a name="input_worker_nodes_instance_types"></a> [worker\_nodes\_instance\_types](#input\_worker\_nodes\_instance\_types) | Managed node group instance type | `list(string)` | <pre>[<br>  "t3.medium"<br>]</pre> | no |
| <a name="input_worker_nodes_labels"></a> [worker\_nodes\_labels](#input\_worker\_nodes\_labels) | Node labels | `map(string)` | `{}` | no |
| <a name="input_worker_nodes_max_size"></a> [worker\_nodes\_max\_size](#input\_worker\_nodes\_max\_size) | Worker Node Group max size | `number` | `5` | no |
| <a name="input_worker_nodes_min_size"></a> [worker\_nodes\_min\_size](#input\_worker\_nodes\_min\_size) | Worker Node Group min size | `number` | `2` | no |
| <a name="input_worker_nodes_taints"></a> [worker\_nodes\_taints](#input\_worker\_nodes\_taints) | Node taints | `list(object({ key = string, value = string, effect = string }))` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cluster_arn"></a> [cluster\_arn](#output\_cluster\_arn) | The Amazon Resource Name (ARN) of the cluster |
| <a name="output_cluster_certificate_authority_data"></a> [cluster\_certificate\_authority\_data](#output\_cluster\_certificate\_authority\_data) | Base64 encoded certificate data required to communicate with the cluster |
| <a name="output_cluster_endpoint"></a> [cluster\_endpoint](#output\_cluster\_endpoint) | Endpoint for your Kubernetes API server |
| <a name="output_cluster_name"></a> [cluster\_name](#output\_cluster\_name) | The name/id of the EKS cluster. Will block on cluster creation until the cluster is really ready |
| <a name="output_cluster_oidc_issuer_url"></a> [cluster\_oidc\_issuer\_url](#output\_cluster\_oidc\_issuer\_url) | The URL on the EKS cluster for the OpenID Connect identity provider |
| <a name="output_cluster_version"></a> [cluster\_version](#output\_cluster\_version) | The Kubernetes version for the cluster |

## Example

```hcl
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

  control_plane_subnet_ids = module.network.vpc_public_subnets_ids
  environment              = ""
  vpc_id                   = ""
  worker_nodes_subnet_ids  = []
}
```
<!-- END_TF_DOCS -->