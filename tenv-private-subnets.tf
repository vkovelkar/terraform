resource "aws_subnet" "terra_private_subnet_az_1" {
  vpc_id     = "${aws_vpc.terra_vpc.id}"
  cidr_block        = "${var.private_subnet_az_1_CIDR}"
  availability_zone = "us-west-2a"

  tags = {
    Name = "Application Subnet 1"
  }

  depends_on = [
    "aws_vpc.terra_vpc"
  ]
}

resource "aws_subnet" "terra_private_subnet_az_2" {
  vpc_id     = "${aws_vpc.terra_vpc.id}"
  cidr_block        = "${var.private_subnet_az_2_CIDR}"
  availability_zone = "us-west-2b"

  tags = {
    Name = "Application Subnet 2"
  }

  depends_on = [
    "aws_vpc.terra_vpc"
  ]
}
