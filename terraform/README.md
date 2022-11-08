# Example - Armada cluster on AWS EKS

This project aims to provide a very straight-forward example of setting up an Armada cluster on AWS EKS.

In order to create an Armada cluster on AWS EKS from scratch, we will use the Terraform modules provided in this repo:
* *network* - creates an AWS VPC with configurable public, private and database subnets
* *k8s* - creates a kubernetes cluster using AWS EKS
* *addons* - installs necessary kubernetes tools needed by Armada

All modules can be used independently, i.e. `k8s` module can be used with an already existing VPC, or `addons` module
can be used with an already existing k8s cluster, but for simplicity, this guide will assume we are starting from scratch.

In the `terraform/examples` folder are examples on how to use each terraform module and sample configurations.

## Dependencies

* [Terraform v1.3.3](https://www.terraform.io/downloads)
* An AWS account - `provider.aws: version = ">= 4.37.0"`

## Usage

**Ensure your AWS credentials are set up.**

This can be done using environment variables:

``` bash
$ export AWS_SECRET_ACCESS_KEY='your secret key'
$ export AWS_ACCESS_KEY_ID='your key id'
```

... or the `~/.aws/credentials` file.

```
$ cat ~/.aws/credentials
[default]
aws_access_key_id = your key id
aws_secret_access_key = your secret key
```

### Terraform workflow

A typical Terraform workflow consists of the following steps:
* init - Initialize Terraform configuration (fetch modules, check access and permissions...)
* plan - Terraform generates a plan of which resources will be provisioned
* apply - Provision the resources from the Terraform plan
* destroy - Destroy provisioned resources

Each example in the Terraform module provides a full flow for the module:
* **network** example - applies the network terraform module.
* **k8s** example - applies the network module, and then it applies the k8s module while referencing required info from the network module.
* **addons** example - applies the network module, then the k8s module, and then it applies the addons module in the newly provisioned k8s cluster.

### Quickstart

The fastest way to create a fully functional Kubernetes cluster in which Armada can be installed immediately, follow this steps:
```bash
# go to the addons example
$ cd terraform/examples/addons
# init terraform configuration
$ terraform init
# review the terraform plan
$ terraform plan
# apply the terraform plan
$ terraform apply
```

#### Cleanup

If you want to destroy all resources which were provisioned through Terraform, run the following command in the same folder where
you have run the apply commands.
```bash
$ terraform destroy
```
