module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = local.vpc.name
  cidr = local.vpc.cidr

  azs              = local.vpc.azs
  public_subnets   = local.vpc.subnets.public_cidrs
  private_subnets  = local.vpc.subnets.private_cidrs
  database_subnets = local.vpc.subnets.database_cidrs

  enable_nat_gateway     = true
  single_nat_gateway     = true
  one_nat_gateway_per_az = false
  enable_vpn_gateway     = true


  vpc_tags = {
    Name = local.vpc.name
  }
  public_subnet_tags = {
    Name                     = local.vpc.subnets.public_name
    "kubernetes.io/role/elb" = 1
  }
  private_subnet_tags = {
    Name                              = local.vpc.subnets.private_name
    "kubernetes.io/role/internal-elb" = 1
  }
  database_subnet_tags = {
    Name = local.vpc.subnets.database_name
  }
  tags = {
    Terraform   = "true"
  }
}
