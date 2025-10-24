resource "aws_route_table" "public" {
  vpc_id = var.vpc_id
  tags = { Name = "public-rt" }
}
resource "aws_route" "public_internet" {
  route_table_id = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = var.igw_id
}
resource "aws_route_table_association" "public_assoc" {
  count = length(var.public_subnet_ids)
  subnet_id = var.public_subnet_ids[count.index]
  route_table_id = aws_route_table.public.id
}
resource "aws_route_table" "private" {
  count = length(var.availability_zones)
  vpc_id = var.vpc_id
  tags = { Name = "private-rt-${var.availability_zones[count.index]}" }
}
resource "aws_route" "private_nat" {
  count = length(var.availability_zones)
  route_table_id = aws_route_table.private[count.index].id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id = var.nat_gateway_ids[count.index]
}
resource "aws_route_table_association" "private_assoc" {
  count = length(var.private_subnet_ids)
  subnet_id = var.private_subnet_ids[count.index]
  route_table_id = aws_route_table.private[count.index].id
}
resource "aws_route_table" "non_routable" {
  vpc_id = var.vpc_id
  tags = { Name = "non-routable-rt" }
}
resource "aws_route_table_association" "non_routable_assoc" {
  count = length(var.non_routable_subnet_ids)
  subnet_id = var.non_routable_subnet_ids[count.index]
  route_table_id = aws_route_table.non_routable.id
}