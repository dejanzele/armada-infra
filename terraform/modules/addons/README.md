<!-- BEGIN_TF_DOCS -->
## Terraform module - addons

This module installs Kubernetes tools which are prerequisites for Armada.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.37.0 |
| <a name="requirement_grafana"></a> [grafana](#requirement\_grafana) | >= 1.30.0 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | >= 2.7.1 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | >= 2.15.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_cert_manager_irsa"></a> [cert\_manager\_irsa](#module\_cert\_manager\_irsa) | terraform-aws-modules/iam/aws//modules/iam-assumable-role-with-oidc | 3.6.0 |
| <a name="module_nginx-controller"></a> [nginx-controller](#module\_nginx-controller) | terraform-iaac/nginx-controller/helm | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_iam_policy.cert_manager_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.external_dns](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.external_dns](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.external_dns](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [grafana_dashboard.metrics](https://registry.terraform.io/providers/grafana/grafana/latest/docs/resources/dashboard) | resource |
| [grafana_data_source.cluster_0](https://registry.terraform.io/providers/grafana/grafana/latest/docs/resources/data_source) | resource |
| [helm_release.cert_manager](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [helm_release.cert_manager_cluster_issuer](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [helm_release.external-dns](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [helm_release.metrics_server](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [helm_release.prometheus](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [kubernetes_ingress_v1.grafana_ingress](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/ingress_v1) | resource |
| [kubernetes_namespace.armada](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace) | resource |
| [kubernetes_namespace.gr_system](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace) | resource |
| [aws_caller_identity.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_eks_cluster.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/eks_cluster) | data source |
| [aws_route53_zone.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route53_zone) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cert_manager_cluster_issuer_email"></a> [cert\_manager\_cluster\_issuer\_email](#input\_cert\_manager\_cluster\_issuer\_email) | Email which will receive notifications about certificates | `string` | n/a | yes |
| <a name="input_k8s_cluster"></a> [k8s\_cluster](#input\_k8s\_cluster) | Name of K8s cluster | `string` | n/a | yes |
| <a name="input_armada_domain"></a> [armada\_domain](#input\_armada\_domain) | Domain under which to create DNS records for Armada components (server, ui, grafana) | `string` | `""` | no |
| <a name="input_aws_profile"></a> [aws\_profile](#input\_aws\_profile) | AWS Profile | `string` | `""` | no |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS Region | `string` | `"us-east-1"` | no |
| <a name="input_cert_manager_cluster_issuer"></a> [cert\_manager\_cluster\_issuer](#input\_cert\_manager\_cluster\_issuer) | cert-manager ClusterIssuer object name | `string` | `"letsencrypt-dev"` | no |
| <a name="input_grafana_create_ingress"></a> [grafana\_create\_ingress](#input\_grafana\_create\_ingress) | Toggle whether to create NGINX ingress for Grafana | `bool` | `false` | no |
| <a name="input_grafana_init"></a> [grafana\_init](#input\_grafana\_init) | Toggle whether to init Grafana with Armada dashboard and datasource (grafana\_create\_ingress needs also to be true) | `bool` | `false` | no |
| <a name="input_install_cert_manager"></a> [install\_cert\_manager](#input\_install\_cert\_manager) | Toggle whether to install Cert Manager Helm chart | `bool` | `true` | no |
| <a name="input_install_metrics_server"></a> [install\_metrics\_server](#input\_install\_metrics\_server) | Toggle whether to install Metrics Server Helm chart | `bool` | `true` | no |
| <a name="input_install_nginx_controller"></a> [install\_nginx\_controller](#input\_install\_nginx\_controller) | Toggle whether to install NGINX Controller Helm chart | `bool` | `true` | no |
| <a name="input_install_prometheus"></a> [install\_prometheus](#input\_install\_prometheus) | Toggle whether to install Prometheus Operator Helm chart | `bool` | `true` | no |

## Outputs

No outputs.

## Example

```hcl
data "aws_eks_cluster" "this" {
  name = module.k8s.cluster_name
}

data "aws_eks_cluster_auth" "aws_iam_authenticator" {
  name = data.aws_eks_cluster.this.name
}

provider "aws" {
  region = "us-east-1"
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.this.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.this.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.aws_iam_authenticator.token
}

provider "helm" {
  kubernetes {
    host                   = data.aws_eks_cluster.this.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.this.certificate_authority[0].data)
    token                  = data.aws_eks_cluster_auth.aws_iam_authenticator.token
  }
}


module "network" {
  source = "git::https://github.com/dejanzele/armada-infra.git//terraform/modules/network"

  vpc_name             = "armada"
  vpc_azs              = ["us-east-1a", "us-east-1b"]
  vpc_cidr             = "10.0.0.0/16"
  vpc_public_subnets   = ["10.0.0.0/20", "10.0.16.0/20"]
  vpc_private_subnets  = ["10.0.32.0/19", "10.0.64.0/19"]
  vpc_database_subnets = ["10.0.96.0/24", "10.0.97.0/24"]
}

module "k8s" {
  source = "git::https://github.com/dejanzele/armada-infra.git//terraform/modules/k8s"

  cluster_name  = "armada"
  eks_node_ami  = "ami-0df25b667dc8fb64d"
  node_key_pair = "dev-armada-debug"

  vpc_id                   = module.network.vpc_id
  control_plane_subnet_ids = module.network.vpc_public_subnets_ids
  worker_nodes_subnet_ids  = module.network.vpc_private_subnets_ids

  create_worker_nodes = true
}


module "addons" {
  source = "git::https://github.com/dejanzele/armada-infra.git//terraform/modules/addons"

  k8s_cluster = module.k8s.cluster_name

  install_cert_manager              = true
  cert_manager_cluster_issuer_email = "service@armadaproject.io"
  install_metrics_server            = true
  install_prometheus                = true
  install_nginx_controller          = true
}
```
<!-- END_TF_DOCS -->