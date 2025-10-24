resource "aws_eip" "nat" {
  count = length(var.availability_zones)
  domain = "vpc"
  tags = { Name = "nat-eip-${var.availability_zones[count.index]}" }
}
resource "aws_nat_gateway" "nat" {
  count = length(var.availability_zones)
  allocation_id = aws_eip.nat[count.index].id
  subnet_id = var.public_subnet_ids[count.index]
  tags = { Name = "nat-${var.availability_zones[count.index]}" }
}