################################################################################

resource "aws_security_group" "remote_access" {
  name        = "${var.vpc_name}-remote-access"
  vpc_id      = "${aws_vpc.scope.id}"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${var.default_ssh_hosts}"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${var.extra_ssh_hosts}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["${var.destination_cidr_block}"]
  }

  tags {
    Name = "${var.vpc_name}-remote-access"
  }
}

################################################################################
