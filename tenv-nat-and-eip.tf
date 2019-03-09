resource "aws_eip" "nat_1" {
  vpc                       = true
  associate_with_private_ip = "${var.ingress_subnet_az_1_nat_ip}"
}

resource "aws_eip" "nat_2" {
  vpc                       = true
  associate_with_private_ip = "${var.ingress_subnet_az_2_nat_ip}"
}

resource "aws_nat_gateway" "gw_1" {
  allocation_id = "${aws_eip.nat_1.id}"
  subnet_id     = "${aws_subnet.terra_ingress_subnet_az_1.id}"

  tags = {
    Name = "gw NAT 1"
  }
}

resource "aws_nat_gateway" "gw_2" {
  allocation_id = "${aws_eip.nat_2.id}"
  subnet_id     = "${aws_subnet.terra_ingress_subnet_az_2.id}"

  tags = {
    Name = "gw NAT 2"
  }
}
