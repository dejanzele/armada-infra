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

data "aws_route53_zone" "this" {
  name = local.dns.zone
}

data "aws_ami" "flatcar_pro_latest" {
  most_recent = true
  owners      = ["aws-marketplace"]

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "name"
    values = ["Flatcar-pro-${var.flatcar_channel}-*"]
  }
}