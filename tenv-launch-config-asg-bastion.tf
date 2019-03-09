resource "aws_launch_configuration" "terra_bastion_lc" {
  name_prefix   = "terraform-bastion-"
  image_id      = "ami-01e24be29428c15b2"
  instance_type = "t2.micro"
  key_name      = "${var.key_name}"
  security_groups = ["${aws_security_group.terra_bastion_sg.id}"]

  lifecycle {
    create_before_destroy = true
  }

  depends_on = [
    "aws_security_group.terra_bastion_sg"
  ]
}

resource "aws_autoscaling_group" "terra-bastion" {
  name                 = "terraform-bastion-asg"
  launch_configuration = "${aws_launch_configuration.terra_bastion_lc.name}"
  min_size             = 1
  max_size             = 1
  vpc_zone_identifier       = ["${aws_subnet.terra_ingress_subnet_az_1.id}"]

  lifecycle {
    create_before_destroy = true
  }

  depends_on = [
    "aws_launch_configuration.terra_bastion_lc",
    "aws_subnet.terra_ingress_subnet_az_1",
  ]
}
