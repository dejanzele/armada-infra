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

variable "k8s_cluster" {
  type        = string
  description = "Name of K8s cluster"
}

variable "armada_domain" {
  type        = string
  description = "Domain for Armada"
}

variable "cert_manager_cluster_issuer_email" {
  type        = string
  description = "Email which will receive notifications about certificaes"
}

variable "install_prometheus" {
  type        = bool
  description = "Toggle whether to install Prometheus Operator Helm chart"
  default     = true
}


variable "install_cert_manager" {
  type        = bool
  description = "Toggle whether to install Cert Manager Helm chart"
  default     = true
}