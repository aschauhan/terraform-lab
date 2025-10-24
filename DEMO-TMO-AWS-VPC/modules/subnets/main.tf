resource "aws_subnet" "public" {
  count = length(var.availability_zones)
  vpc_id = var.vpc_id
  cidr_block = cidrsubnet(var.vpc_cidr, 8, count.index + 1)
  availability_zone = var.availability_zones[count.index]
  map_public_ip_on_launch = true
  tags = { Name = "${var.env}-public-subnet-${var.availability_zones[count.index]}", Type = "public" }
}
resource "aws_subnet" "private" {
  count = length(var.availability_zones)
  vpc_id = var.vpc_id
  cidr_block = cidrsubnet(var.vpc_cidr, 8, count.index + 11)
  availability_zone = var.availability_zones[count.index]
  tags = { Name = "${var.env}-private-subnet-${var.availability_zones[count.index]}", Type = "private" }
}
resource "aws_subnet" "non_routable" {
  count = length(var.availability_zones)
  vpc_id = var.vpc_id
  cidr_block = cidrsubnet(var.vpc_cidr, 8, count.index + 21)
  availability_zone = var.availability_zones[count.index]
  tags = { Name = "${var.env}-non-routable-subnet-${var.availability_zones[count.index]}", Type = "non-routable" }
}