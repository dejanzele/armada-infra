resource "aws_launch_template" "launch_template" {
  name_prefix            = "${local.lt.name}-"
  description            = "EKS managed node group external launch template for Flatcar Pro AMI"
  update_default_version = true
  key_name               = local.k8s.key_pair

  block_device_mappings {
    device_name = "/dev/xvda"

    ebs {
      volume_size           = 100
      volume_type           = "gp2"
      delete_on_termination = true
    }
  }

  monitoring {
    enabled = true
  }

  #   Disabling due to https://github.com/hashicorp/terraform-provider-aws/issues/23766
  #   network_interfaces {
  #     associate_public_ip_address = false
  #     delete_on_termination       = true
  #   }

  #if you want to use a custom AMI
  image_id = local.k8s.ami

  # If you use a custom AMI, you need to supply via user-data, the bootstrap script as EKS DOESNT merge its managed user-data then
  # you can add more than the minimum code you see in the template, e.g. install SSM agent, see https://github.com/aws/containers-roadmap/issues/593#issuecomment-577181345
  # (optionally you can use https://registry.terraform.io/providers/hashicorp/cloudinit/latest/docs/data-sources/cloudinit_config to render the script, example: https://github.com/terraform-aws-modules/terraform-aws-eks/pull/997#issuecomment-705286151)
  user_data = base64encode(templatefile("${path.module}/bootstrap.sh", { CLUSTER_NAME = local.k8s.cluster_name }))

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name      = local.k8s.cluster_name
      CustomTag = "Instance custom tag"
    }
  }

  tag_specifications {
    resource_type = "volume"

    tags = {
      CustomTag = "Volume custom tag"
    }
  }

  tag_specifications {
    resource_type = "network-interface"

    tags = {
      CustomTag = "EKS example"
    }
  }

  tags = {
    CustomTag = "Launch template custom tag"
  }

  lifecycle {
    create_before_destroy = true
  }
}