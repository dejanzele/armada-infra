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
  description = "Email which will receive notifications about certificates"
}

variable "install_prometheus" {
  type        = bool
  description = "Toggle whether to install Prometheus Operator Helm chart"
  default     = true
}

variable "install_metrics_server" {
  type        = bool
  description = "Toggle whether to install Metrics Server Helm chart"
  default     = true
}

variable "install_cert_manager" {
  type        = bool
  description = "Toggle whether to install Cert Manager Helm chart"
  default     = true
}

variable "cert_manager_cluster_issuer" {
  type        = string
  description = "cert-manager ClusterIssuer object name"
  default     = "letsencrypt-dev"
}

variable "grafana_create_ingress" {
  type        = bool
  description = "Toggle whether to create NGINX ingress for Grafana"
  default     = false
}

variable "grafana_init" {
  type        = bool
  description = "Toggle whether to init Grafana with Armada dashboard and datasource (grafana_create_ingress needs also to be true)"
  default     = false
}
