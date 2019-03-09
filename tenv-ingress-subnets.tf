resource "aws_subnet" "terra_ingress_subnet_az_1" {
  vpc_id     = "${aws_vpc.terra_vpc.id}"
  cidr_block        = "${var.ingress_subnet_az_1_CIDR}"
  availability_zone = "us-west-2a"
  map_public_ip_on_launch = "true"

  tags = {
    Name = "Ingress Subnet 1"
  }

  depends_on = [
    "aws_vpc.terra_vpc"
  ]
}

resource "aws_subnet" "terra_ingress_subnet_az_2" {
  vpc_id     = "${aws_vpc.terra_vpc.id}"
  cidr_block        = "${var.ingress_subnet_az_2_CIDR}"
  availability_zone = "us-west-2b"
  map_public_ip_on_launch = "true"

  tags = {
    Name = "Ingress Subnet 2"
  }

  depends_on = [
    "aws_vpc.terra_vpc"
  ]
}
