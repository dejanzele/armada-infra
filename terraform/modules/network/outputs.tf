output "vpc_name" {
  description = "The name of the VPC specified as argument to this module"
  value       = module.vpc.name
}

output "vpc_azs" {
  description = "A list of availability zones specified as argument to this module"
  value       = module.vpc.azs
}

output "vpc_id" {
  description = "VPC ID"
  value       = module.vpc.vpc_id
}

output "vpc_public_subnets_ids" {
  description = "List of IDs of public subnets"
  value       = module.vpc.public_subnets
}

output "vpc_private_subnets_ids" {
  description = "List of IDs of private subnets"
  value       = module.vpc.private_subnets
}

output "vpc_database_subnets_ids" {
  description = "List of IDs of database subnets"
  value       = module.vpc.database_subnets
}

output "vpc_public_subnets_cidr_blocks" {
  description = "List of IDs of public subnets CIDR blocks"
  value       = module.vpc.public_subnets_cidr_blocks
}

output "vpc_private_subnets_cidr_blocks" {
  description = "List of IDs of private subnets CIDR blocks"
  value       = module.vpc.public_subnets_cidr_blocks
}

output "vpc_database_subnets_cidr_blocks" {
  description = "List of IDs of database subnets CIDR blocks"
  value       = module.vpc.public_subnets_cidr_blocks
}
