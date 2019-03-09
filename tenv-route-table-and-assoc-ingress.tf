resource "aws_route_table" "ingress_route_table" {
  vpc_id = "${aws_vpc.terra_vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.terra_gw.id}"
  }

  depends_on = [
    "aws_vpc.terra_vpc",
    "aws_internet_gateway.terra_gw"
  ]
}

resource "aws_route_table_association" "ingress_route_table_assoc_az_1" {
  count          = "${var.az_count}"
  subnet_id      = "${aws_subnet.terra_ingress_subnet_az_1.id}"
  route_table_id = "${aws_route_table.ingress_route_table.id}"

  depends_on = [
    "aws_subnet.terra_ingress_subnet_az_1",
    "aws_route_table.ingress_route_table",
  ]
}

resource "aws_route_table_association" "ingress_route_table_assoc_az_2" {
  count          = "${var.az_count}"
  subnet_id      = "${aws_subnet.terra_ingress_subnet_az_2.id}"
  route_table_id = "${aws_route_table.ingress_route_table.id}"

  depends_on = [
    "aws_subnet.terra_ingress_subnet_az_2",
    "aws_route_table.ingress_route_table"
  ]
}
