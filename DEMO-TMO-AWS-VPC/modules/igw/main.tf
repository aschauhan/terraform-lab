resource "aws_internet_gateway" "tm-int-gw" {
  vpc_id = var.vpc_id
  tags = { Name = "igw-${var.vpc_id}" }
}
