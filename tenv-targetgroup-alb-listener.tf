resource "aws_alb_target_group" "terra_alb_target_group" {
  name     = "garrett-terra-alb-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "${aws_vpc.terra_vpc.id}"

  depends_on = [
    "aws_vpc.terra_vpc"
  ]
}

resource "aws_alb" "terra_alb" {
  name               = "garretts-terra-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = ["${aws_security_group.garrett_terra_alb_sg.id}"]
  subnets            = ["${aws_subnet.terra_ingress_subnet_az_1.id}","${aws_subnet.terra_ingress_subnet_az_2.id}"]

  enable_deletion_protection = false

  tags = {
    Environment = "production"
  }

  depends_on = [
    "aws_security_group.garrett_terra_alb_sg",
    "aws_subnet.terra_ingress_subnet_az_1",
    "aws_subnet.terra_ingress_subnet_az_2"
  ]
}

resource "aws_alb_listener" "terra_alb_listener" {
  load_balancer_arn = "${aws_alb.terra_alb.id}"
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = "${aws_alb_target_group.terra_alb_target_group.id}"
    type             = "forward"
  }

  depends_on = [
    "aws_alb.terra_alb",
    "aws_alb_target_group.terra_alb_target_group"
  ]
}
