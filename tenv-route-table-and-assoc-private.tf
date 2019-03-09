resource "aws_route_table" "app_route_table_1" {
  vpc_id = "${aws_vpc.terra_vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_nat_gateway.gw_1.id}"
  }

  depends_on = [
    "aws_vpc.terra_vpc",
    "aws_nat_gateway.gw_1"
  ]
}

resource "aws_route_table_association" "app_route_table_assoc_az_1" {
  count          = "${var.az_count}"
  subnet_id      = "${aws_subnet.terra_private_subnet_az_1.id}"
  route_table_id = "${aws_route_table.app_route_table_1.id}"

  depends_on = [
    "aws_subnet.terra_private_subnet_az_1",
    "aws_route_table.app_route_table_1"
  ]
}

resource "aws_route_table" "app_route_table_2" {
  vpc_id = "${aws_vpc.terra_vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_nat_gateway.gw_2.id}"
  }

  depends_on = [
    "aws_vpc.terra_vpc",
    "aws_nat_gateway.gw_2"
  ]
}

resource "aws_route_table_association" "app_route_table_assoc_az_2" {
  count          = "${var.az_count}"
  subnet_id      = "${aws_subnet.terra_private_subnet_az_2.id}"
  route_table_id = "${aws_route_table.app_route_table_2.id}"

  depends_on = [
    "aws_subnet.terra_private_subnet_az_2",
    "aws_route_table.app_route_table_2"
  ]
}
