variable "environment" {
  type = string
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

variable "k8s_version" {
  type        = string
  description = "K8s API version"
  default     = "1.21"
}

variable "aws_auth_users" {
  type        = list(object({userarn=string, username=string, groups=list(string)}))
  description = "List of IAM users to grant access to the cluster"
  default     = []
}

variable "aws_auth_roles" {
  type        = list(object({rolearn=string, username=string, groups=list(string)}))
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