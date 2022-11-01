variable "environment" {
  type        = string
  description = "Environment (dev, qa, prod...)"
}

variable "aws_region" {
  type        = string
  description = "AWS Region"
  default     = "us-east-1"
}

variable "aws_profile" {
  type        = string
  description = "AWS Profile"
  default     = ""
}

variable "vpc_id" {
  type        = string
  description = "VPC ID in which to provision the k8s cluster"
}

variable "control_plane_subnet_ids" {
  type        = list(string)
  description = "List of VPC Subnet IDs in which to provision the k8s control plane"
}

variable "worker_nodes_subnet_ids" {
  type        = list(string)
  description = "List of VPC Subnet IDs in which to provision the k8s worker nodes"
}

// k8s

variable "cluster_name" {
  type        = string
  description = "K8s cluster name"
}

variable "eks_node_ami" {
  type        = string
  description = "AMI for k8s nodes (default is for k8s v1.23 in us-east-1 region)"
  default     = "ami-0df25b667dc8fb64d"
}

variable "aws_additional_role" {
  type        = string
  description = "Additional IAM role to add in aws-auth configmap"
  default     = ""
}

variable "aws_auth_users" {
  type        = list(object({ userarn = string, username = string, groups = list(string) }))
  description = "List of IAM users to grant access to the cluster"
  default     = []
}

variable "aws_auth_roles" {
  type        = list(object({ rolearn = string, username = string, groups = list(string) }))
  description = "List of IAM roles to grant access to the cluster"
  default     = []
}

variable "aws_auth_accounts" {
  type        = list(string)
  description = "List of AWS accounts to grant access to the cluster"
  default     = []
}

variable "create_system_nodes" {
  type        = bool
  description = "Toggle should create managed node group for system nodes"
  default     = true
}

variable "system_node_taints" {
  type        = list(object({ key = string, value = string, effect = string }))
  description = "System node taints"
  default     = []
}

variable "system_node_labels" {
  type        = map(string)
  description = "System node labels"
  default     = {}
}

variable "system_nodes_instance_types" {
  type        = list(string)
  description = "Managed node group instance type"
  default     = ["t3.medium"]
}

variable "system_nodes_max_size" {
  type        = number
  description = "System Node Group max size"
  default     = 5
}

variable "system_nodes_min_size" {
  type        = number
  description = "System Node Group min size"
  default     = 2
}

variable "system_nodes_desired_size" {
  type        = number
  description = "System Node Group desired size"
  default     = 3
}

variable "create_worker_nodes" {
  type        = bool
  description = "Toggle should create managed node group for worker nodes"
  default     = false
}

variable "worker_nodes_taints" {
  type        = list(object({ key = string, value = string, effect = string }))
  description = "Node taints"
  default     = []
}

variable "worker_nodes_labels" {
  type        = map(string)
  description = "Node labels"
  default     = {}
}

variable "worker_nodes_instance_types" {
  type        = list(string)
  description = "Managed node group instance type"
  default     = ["t3.medium"]
}

variable "worker_nodes_max_size" {
  type        = number
  description = "Worker Node Group max size"
  default     = 5
}

variable "worker_nodes_min_size" {
  type        = number
  description = "Worker Node Group min size"
  default     = 2
}

variable "worker_nodes_desired_size" {
  type        = number
  description = "Worker Node Group desired size"
  default     = 3
}

variable "node_key_pair" {
  type        = string
  description = "Key Pair to SSH into worker/system nodes"
}

variable "install_calico_cni" {
  type        = bool
  description = "Toggle whether to install Calico CNI"
  default     = false
}

variable "install_nvidia_device_plugin" {
  type        = bool
  description = "Toggle whether to install NVIDIA Device Plugin"
  default     = false
}
