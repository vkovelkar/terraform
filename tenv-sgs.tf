resource "aws_security_group" "garrett_terra_alb_sg" {
  name        = "garrett_terra_alb_sg"
  description = "Allow all inbound traffic"
  vpc_id     = "${aws_vpc.terra_vpc.id}"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["${var.private_subnet_az_1_CIDR}"]
  }

  egress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["${var.private_subnet_az_2_CIDR}"]
  }

  tags = {
    Name = "garrett_terra_alb_sg"
  }

  depends_on = [
    "aws_vpc.terra_vpc"
  ]
}

resource "aws_security_group" "terra_app_server_sg" {
  name        = "terra_app_server_sg"
  description = "Allow all inbound traffic"
  vpc_id     = "${aws_vpc.terra_vpc.id}"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["${var.ingress_subnet_az_1_CIDR}"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["${var.ingress_subnet_az_2_CIDR}"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${var.ingress_subnet_az_1_CIDR}"]
  }

  tags = {
    Name = "terra_app_server_sg"
  }

  depends_on = [
    "aws_vpc.terra_vpc"
  ]
}

resource "aws_security_group" "terra_bastion_sg" {
  name        = "terra_bastion_sg"
  description = "Allow all inbound traffic"
  vpc_id     = "${aws_vpc.terra_vpc.id}"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${var.bastion_ssh_from}"]
  }

  egress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${var.private_subnet_az_1_CIDR}"]
  }

  egress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${var.private_subnet_az_2_CIDR}"]
  }

  tags = {
    Name = "terra_bastion_sg"
  }

  depends_on = [
    "aws_vpc.terra_vpc"
  ]
}
