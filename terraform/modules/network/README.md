<!-- BEGIN_TF_DOCS -->
## Terraform module - network

This module creates a three-tier AWS VPC with public, private and database subnets.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.37.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_vpc"></a> [vpc](#module\_vpc) | terraform-aws-modules/vpc/aws | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_vpc_cidr"></a> [vpc\_cidr](#input\_vpc\_cidr) | VPC CIDR range | `string` | n/a | yes |
| <a name="input_vpc_name"></a> [vpc\_name](#input\_vpc\_name) | VPC Name | `string` | n/a | yes |
| <a name="input_aws_profile"></a> [aws\_profile](#input\_aws\_profile) | AWS Profile | `string` | `""` | no |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS Region | `string` | `"us-east-1"` | no |
| <a name="input_vpc_azs"></a> [vpc\_azs](#input\_vpc\_azs) | Availability Zones | `list(string)` | <pre>[<br>  "us-east-1a",<br>  "us-east-1b"<br>]</pre> | no |
| <a name="input_vpc_database_subnets"></a> [vpc\_database\_subnets](#input\_vpc\_database\_subnets) | VPC Database Subnet CIDR ranges | `list(string)` | `[]` | no |
| <a name="input_vpc_private_subnets"></a> [vpc\_private\_subnets](#input\_vpc\_private\_subnets) | VPC Private Subnet CIDR ranges | `list(string)` | `[]` | no |
| <a name="input_vpc_public_subnets"></a> [vpc\_public\_subnets](#input\_vpc\_public\_subnets) | VPC Public Subnet CIDR ranges | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_vpc_azs"></a> [vpc\_azs](#output\_vpc\_azs) | A list of availability zones specified as argument to this module |
| <a name="output_vpc_database_subnets_cidr_blocks"></a> [vpc\_database\_subnets\_cidr\_blocks](#output\_vpc\_database\_subnets\_cidr\_blocks) | List of IDs of database subnets CIDR blocks |
| <a name="output_vpc_database_subnets_ids"></a> [vpc\_database\_subnets\_ids](#output\_vpc\_database\_subnets\_ids) | List of IDs of database subnets |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | VPC ID |
| <a name="output_vpc_name"></a> [vpc\_name](#output\_vpc\_name) | The name of the VPC specified as argument to this module |
| <a name="output_vpc_private_subnets_cidr_blocks"></a> [vpc\_private\_subnets\_cidr\_blocks](#output\_vpc\_private\_subnets\_cidr\_blocks) | List of IDs of private subnets CIDR blocks |
| <a name="output_vpc_private_subnets_ids"></a> [vpc\_private\_subnets\_ids](#output\_vpc\_private\_subnets\_ids) | List of IDs of private subnets |
| <a name="output_vpc_public_subnets_cidr_blocks"></a> [vpc\_public\_subnets\_cidr\_blocks](#output\_vpc\_public\_subnets\_cidr\_blocks) | List of IDs of public subnets CIDR blocks |
| <a name="output_vpc_public_subnets_ids"></a> [vpc\_public\_subnets\_ids](#output\_vpc\_public\_subnets\_ids) | List of IDs of public subnets |

## Example

```hcl
provider "aws" {
  region = "us-east-1"
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
```
<!-- END_TF_DOCS -->