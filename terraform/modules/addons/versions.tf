terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = ">= 4.37.0"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = ">= 2.15.0"
    }
    helm = {
      source = "hashicorp/helm"
      version = ">= 2.7.1"
    }
    grafana = {
      source = "grafana/grafana"
      version = ">= 1.30.0"
    }
  }
}
