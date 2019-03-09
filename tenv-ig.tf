resource "aws_internet_gateway" "terra_gw" {
  vpc_id = "${aws_vpc.terra_vpc.id}"

  depends_on = [
    "aws_vpc.terra_vpc"
  ]
}
