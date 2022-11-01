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
  default     = ""
}

variable "vpc_name" {
  type        = string
  description = "VPC Name"
}

variable "vpc_cidr" {
  type        = string
  description = "VPC CIDR range"
}

variable "vpc_azs" {
  type        = list(string)
  description = "Availability Zones"
  default     = ["us-east-1a", "us-east-1b"]
}

variable "vpc_public_subnets" {
  type        = list(string)
  description = "VPC Public Subnet CIDR ranges"
  default     = []
}

variable "vpc_private_subnets" {
  type        = list(string)
  description = "VPC Private Subnet CIDR ranges"
  default     = []
}

variable "vpc_database_subnets" {
  type        = list(string)
  description = "VPC Database Subnet CIDR ranges"
  default     = []
}
