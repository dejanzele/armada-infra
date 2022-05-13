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
  type = string
  description = "K8s cluster name"
}

variable "k8s_version" {
  type = string
  description = "K8s API version"
  default = "1.21"
}
