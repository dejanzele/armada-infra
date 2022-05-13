data "aws_vpc" "vpc" {
  tags = {
    Name = local.vpc.name
  }
}

data "aws_subnets" "public" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.vpc.id]
  }

  tags = {
    Name = local.vpc.subnets.public_name
  }
}

data "aws_subnets" "private" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.vpc.id]
  }

  tags = {
    Name = local.vpc.subnets.private_name
  }
}
