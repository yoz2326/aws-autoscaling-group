################################################################################

variable "aws_region" { default = "eu-west-1"                       }
variable "vpc_name"   { default = "vpc01"                           }
variable "vpc_cidr"   { default = "192.168.0.0/20"                  }
variable "vpc_domain" { default = "eu-west-1.compute.amazonaws.com" }

variable "availability_zones" {
  default  = "eu-west-1a,eu-west-1b,eu-west-1c"
}

################################################################################

variable "subnet_cidr_public_1a"  { default = "192.168.1.0/24"           }
variable "subnet_cidr_public_2b"  { default = "192.168.2.0/24"           }
variable "subnet_cidr_public_3c"  { default = "192.168.3.0/24"           }

variable "public_key_path"        { default = "../secrets/ssh/vpc01.pub" }

variable "default_ssh_hosts"      { default = "192.168.0.0/20"           }
variable "extra_ssh_hosts"        { default = "1.1.1.1/32"               }

variable "destination_cidr_block" { default = "0.0.0.0/0"                }

################################################################################

variable "aws_ami"       { default = "ami-c0cff0a6" }
variable "instance_type" { default = "t2.micro"     }

variable "auto_scaling_group_min" { default = "1" }
variable "auto_scaling_group_max" { default = "1" }

################################################################################
