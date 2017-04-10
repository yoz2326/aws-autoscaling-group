################################################################################

resource "aws_autoscaling_group" "autoscaling_group" {
  availability_zones        = ["${split(",", var.availability_zones)}"]
  name                      = "mue_master_node"
  max_size                  = "${var.auto_scaling_group_min}"
  min_size                  = "${var.auto_scaling_group_max}"
  force_delete              = true
  launch_configuration      = "${aws_launch_configuration.launch_configuration.id}"
  wait_for_capacity_timeout = "0"
  health_check_type         = "EC2"

  vpc_zone_identifier       = ["${aws_subnet.public_1a.id},${aws_subnet.public_2b.id},${aws_subnet.public_3c.id}"]

  tag {
    key                 = "Name"
    value               = "mue_master_node"
    propagate_at_launch = "true"
  }
  tag {
    key                 = "VPC"
    value               = "${var.vpc_name}"
    propagate_at_launch = "true"
  }
}

################################################################################

resource "aws_launch_configuration" "launch_configuration" {
  name          = "mue_master_node"
  image_id      = "${var.aws_ami      }"
  instance_type = "${var.instance_type}"

  security_groups             = ["${aws_security_group.remote_access.id}"]
  user_data                   = "${file("files/userdata.sh")           }"
  key_name                    = "${var.vpc_name                        }"

}

################################################################################
