################################################################################

provider "aws" {
  region = "${var.aws_region}"
}

#################################################################################

resource "aws_vpc" "scope" {
  cidr_block           = "${var.vpc_cidr}"
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  tags {
    Name = "${var.vpc_name}"
   }
}

################################################################################

resource "aws_key_pair" "auth" {
  key_name   = "${var.vpc_name}"
  public_key = "${file(var.public_key_path)}"
}

################################################################################

resource "aws_internet_gateway" "scope" {
  vpc_id = "${aws_vpc.scope.id}"
  tags {
    Name = "${var.vpc_name}"
  }
}

################################################################################

resource "aws_route_table" "public" {
  vpc_id = "${aws_vpc.scope.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.scope.id}"
  }

  tags {
    VPC  = "${var.vpc_name}"
    Name = "${var.vpc_name}-public"
  }
}

################################################################################

resource "aws_main_route_table_association" "scope" {
  route_table_id = "${aws_route_table.public.id}"
  vpc_id         = "${aws_vpc.scope.id         }"
}


################################################################################

resource "aws_subnet" "public_1a" {
  vpc_id                  = "${aws_vpc.scope.id         }"
  cidr_block              = "${var.subnet_cidr_public_1a}"
  availability_zone       = "${var.aws_region           }a"
  map_public_ip_on_launch = true
  tags {
    Name = "${var.vpc_name}-public-1a"
  }
}

resource "aws_route_table_association" "public_1a" {
    subnet_id      = "${aws_subnet.public_1a.id  }"
    route_table_id = "${aws_route_table.public.id}"
}

################################################################################

resource "aws_subnet" "public_2b" {
  vpc_id                  = "${aws_vpc.scope.id         }"
  cidr_block              = "${var.subnet_cidr_public_2b}"
  availability_zone       = "${var.aws_region           }b"
  map_public_ip_on_launch = true
  tags {
    Name = "${var.vpc_name}-public-2b"
  }
}

resource "aws_route_table_association" "public_2b" {
    subnet_id      = "${aws_subnet.public_2b.id  }"
    route_table_id = "${aws_route_table.public.id}"
}

################################################################################

resource "aws_subnet" "public_3c" {
  vpc_id                  = "${aws_vpc.scope.id         }"
  cidr_block              = "${var.subnet_cidr_public_3c}"
  availability_zone       = "${var.aws_region           }c"
  map_public_ip_on_launch = true
  tags {
    Name = "${var.vpc_name}-public-3c"
  }
}

resource "aws_route_table_association" "public_3c" {
    subnet_id      = "${aws_subnet.public_3c.id  }"
    route_table_id = "${aws_route_table.public.id}"
}

################################################################################
