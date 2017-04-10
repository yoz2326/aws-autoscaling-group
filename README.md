autoscaling-group-basic
==================================

Terraform sample code which builds a basic autoscaling group (ASG) in the EU-WEST-1 region across all 3 availability zones (AZ).
The ASG has a `min` and `max` of `1` so it will always launch a single EC2 instance.
It spans 3 public subnets having `map_public_ip_on_launch` set to `true` so the instance will have its own public IP.
The EC2 instance is protected by a security group which by default allows SSH from the VPC CIDR range and your computer public IP.

**Supported Cloud Providers:** Amazon

**OS utilized by the EC2 instance:** Ubuntu 16.04 LTS x64

### Requirements
- [AWS account](https://aws.amazon.com/console/)       : valid AWS keys
- [Terraform](https://www.terraform.io/downloads.html) : terraform available in the search path

### How to use

Simply run `build-master-node.sh` script on you have configured your AWS keys and have terraform available in the search path.
Alternatively, `cd terraform` and run `. ./files/remote-state.sh` followed by `terraform plan .`,  `terraform apply .` and `terraform remote push`
(first you will have to export AWS keys as local variables for terraform to use them)

See below for more details on usage.

### Terraform actions

- build a VPC in eu-west-1 region
- dns_hostnames enabled in the VPC
- uploads ssh key to be used by the ec2 instance
- 1 public route table; default route uses internet gateway; it is the main route in the VPC
- 3 public subnets; public IP allocation enabled; associated with the public route table
- 1 security group associated with the EC2 instance allowing:
    - SSH from the VPC cidr range and your computer public IP address
    - All outboud access

**Terraform prep:**

Create your ssh key files and add to `secrets/ssh/`.
Use these file names: `key_name=vpc_name`, `pub_key=vpc_name.pub`.
Add AWS keys to `secrets/aws/creds.sh` file.
Create an S3 bucket in your AWS account for terraform to store the state.
The bucket name has to be updated in `terraform/files/remote-state.sh` (for example: `-backend-config="bucket=mue-masternode-terraform-04b062a1-0cad-46a7-ba24-6fdc0484e1f3"` ).
Open `terraform/vars.tf` to review and update defaults if needed (if you wish to use different VPC name or IP ranges; default VPC name: VPC01; default cidr range: 192.168.0.0/20)

*Provisioning:*
Run `build-master-node.sh` to provision the infrastructure. This script will:
  - source `secrets/aws/creds.sh` to set terraform environment variables
  - configure and pull remote terrafrom state
  - execute terraform plan
  - ask if you wish to run terrafrom apply if planning goes without errors
  - execute terraform apply if decided to do so
  - unsets terrafrom environment variables as a last step

*Destroying:*
Run `destroy-master-node.sh` to destroy all provisioned infrastructure in AWS.


**Terraform vars**
Run ``

File `terraform\vars.tf` contains variables used for our infrastructure.
The most important are:
 - vpc name
 - vpc cidr block
 - subnets cidr ranges
 - addittional IPs for allowing SSH access (default overriden via `terraform.tfvars`)


### Folders

 - `terraform`: terraform code, files split by function
 - `secrets`  : holds the ssh key and AWS creds file used by terraform
