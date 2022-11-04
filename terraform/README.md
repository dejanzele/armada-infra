# Example - Armada cluster on AWS EKS

This project aims to provide a very straight-forward example of setting up an Armada cluster on AWS EKS.

In order to create an Armada cluster on AWS EKS from scratch, we will use the Terraform modules provided in this repo:
* *network* - create an AWS VPC
* k8s - create a kubernetes cluster using AWS EKS
* addons - install necessary kubernetes tools needed by Armada

## Dependencies

* [Terraform >= v1.3.3](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)
* An AWS account [AWS-CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)

## Usage

**1\. Ensure your AWS credentials are set up.**

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

### network

**2\. Review the Terraform plan.**

Execute the below command and ensure you are happy with the plan.

``` bash
$ cd terraform/examples/network
$ terraform plan
```
This project currently does the below deployments:

- MongoDB cluster - M10
- AWS Custom VPC, Internet Gateway, Route Tables, Subnets with Public and Private access
- PrivateLink Connection at MongoDB Atlas
- Create VPC Endpoint in AWS

**3\. Configure the security group as required.**

The security group in this configuration allows All Traffic access in Inbound and Outbound Rules.

**4\. Execute the Terraform apply.**

Now execute the plan to provision the AWS and Atlas resources.

``` bash
$ terraform apply
```

**5\. Destroy the resources.**

Once you are finished your testing, ensure you destroy the resources to avoid unnecessary charges.

``` bash
$ terraform destroy
```

**Important Point**

To fetch the connection string follow the below steps:
```
output "atlasclusterstring" {
    value = mongodbatlas_cluster.cluster-atlas.connection_strings
}
```
**Outputs:**
```
atlasclusterstring = [
  {
    "aws_private_link" = {
      "vpce-0ebb76559e8affc96" = "mongodb://pl-0-us-east-1.za3fb.mongodb.net:1024,pl-0-us-east-1.za3fb.mongodb.net:1025,pl-0-us-east-1.za3fb.mongodb.net:1026/?ssl=true&authSource=admin&replicaSet=atlas-d177ke-shard-0"
    }
    "aws_private_link_srv" = {
      "vpce-0ebb76559e8affc96" = "mongodb+srv://cluster-atlas-pl-0.za3fb.mongodb.net"
    }
    "private" = ""
    "private_srv" = ""
    "standard" = "mongodb://cluster-atlas-shard-00-00.za3fb.mongodb.net:27017,cluster-atlas-shard-00-01.za3fb.mongodb.net:27017,cluster-atlas-shard-00-02.za3fb.mongodb.net:27017/?ssl=true&authSource=admin&replicaSet=atlas-d177ke-shard-0"
    "standard_srv" = "mongodb+srv://cluster-atlas.za3fb.mongodb.net"
  },
]
```

To fetch a particular connection string, use the **lookup()** function of terraform as below:

```
output "plstring" {
    value = lookup(mongodbatlas_cluster.cluster-atlas.connection_strings[0].aws_private_link_srv, aws_vpc_endpoint.ptfe_service.id)
}
```
**Output:**
```
plstring = mongodb+srv://cluster-atlas-pl-0.za3fb.mongodb.net
```
