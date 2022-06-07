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
  default     = "armada"
}

variable "cluster_name" {
  type        = string
  description = "K8s cluster name"
}

variable "eks_node_ami" {
  type        = string
  description = "AMI for k8s nodes"
}

variable "k8s_version" {
  type        = string
  description = "K8s API version"
  default     = "1.21"
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

variable "r53_zone" {
  type        = string
  description = "Armada hosted zone"
  default     = "dev.armadaproject.io"
}

variable "create_system_nodes" {
  type        = bool
  description = "Toggle should create managed node group for system nodes"
  default     = true
}

variable "system_node_taints" {
  type        = list(object({ key = string, value = string, effect = string }))
  description = "Node taints"
  default     = []
}

variable "system_bootstrap_extra_args" {
  type        = string
  description = "Bootstrap extra arguments"
  default     = ""
}

variable "system_nodes_instance_types" {
  type        = list(string)
  description = "Managed node group instance type"
  default     = ["t3.large"]
}

variable "system_nodes_max_size" {
  type        = number
  description = "System Node Group max size"
  default     = 5
}

variable "system_nodes_min_size" {
  type        = number
  description = "System Node Group min size"
  default     = 3
}

variable "system_nodes_desired_size" {
  type        = number
  description = "System Node Group desired size"
  default     = 4
}

variable "create_worker_nodes" {
  type        = bool
  description = "Toggle should create managed node group for worker nodes"
  default     = false
}

variable "worker_node_taints" {
  type        = list(object({ key = string, value = string, effect = string }))
  description = "Node taints"
  default     = []
}

variable "worker_bootstrap_extra_args" {
  type        = string
  description = "Bootstrap extra arguments"
  default     = ""
}

variable "worker_nodes_instance_types" {
  type        = list(string)
  description = "Managed node group instance type"
  default     = ["t3.large"]
}

variable "worker_nodes_max_size" {
  type        = number
  description = "Worker Node Group max size"
  default     = 5
}

variable "worker_nodes_min_size" {
  type        = number
  description = "Worker Node Group min size"
  default     = 3
}

variable "worker_nodes_desired_size" {
  type        = number
  description = "Worker Node Group desired size"
  default     = 4
}

variable "flatcar_channel" {
  type        = string
  description = "Flatcar channel to deploy on instances"
  default     = "stable"
}

variable "node_key_pair" {
  type        = string
  description = "Key Pair to SSH into worker/system nodes"
  default     = null
}

variable "install_calico_cni" {
  type        = bool
  description = "Toggle whether to install Calico CNI"
  default     = true
}

variable "install_nvidia_device_plugin" {
  type        = bool
  description = "Toggle whether to install NVIDIA Device Plugin"
  default     = false
}