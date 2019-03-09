data "aws_ami" "nginx-ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["nginx-plus-ami-ubuntu-hvm-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["679593333241"] # Canonical
}

resource "aws_launch_configuration" "terra_lc" {
  name_prefix   = "terraform-lc-example-"
  image_id      = "${data.aws_ami.nginx-ubuntu.id}"
  instance_type = "t2.micro"
  key_name      = "${var.key_name}"
  security_groups = ["${aws_security_group.terra_app_server_sg.id}"]

  lifecycle {
    create_before_destroy = true
  }

  depends_on = [
    "aws_security_group.terra_app_server_sg"
  ]
}

resource "aws_autoscaling_group" "terra-app-asg_az_1" {
  name                 = "terraform-asg-example-1"
  launch_configuration = "${aws_launch_configuration.terra_lc.name}"
  min_size             = 1
  max_size             = 2
  vpc_zone_identifier       = ["${aws_subnet.terra_private_subnet_az_1.id}"]
  target_group_arns         = ["${aws_alb_target_group.terra_alb_target_group.id}"]

  lifecycle {
    create_before_destroy = true
  }

  depends_on = [
    "aws_launch_configuration.terra_lc",
    "aws_subnet.terra_private_subnet_az_1",
    "aws_alb_target_group.terra_alb_target_group"
  ]
}

resource "aws_autoscaling_group" "terra-app-asg_az_2" {
  name                 = "terraform-asg-example-2"
  launch_configuration = "${aws_launch_configuration.terra_lc.name}"
  min_size             = 1
  max_size             = 2
  vpc_zone_identifier       = ["${aws_subnet.terra_private_subnet_az_2.id}"]
  target_group_arns         = ["${aws_alb_target_group.terra_alb_target_group.id}"]

  lifecycle {
    create_before_destroy = true
  }

  depends_on = [
    "aws_launch_configuration.terra_lc",
    "aws_subnet.terra_private_subnet_az_2",
    "aws_alb_target_group.terra_alb_target_group"
  ]
}
