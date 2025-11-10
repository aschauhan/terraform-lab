resource "aws_internet_gateway" "igw" {
  vpc_id = var.vpc_id

  tags = merge(
    { Name = "${var.name}-igw" },
    var.tags
  )
}

resource "aws_eip" "nat_public" {
  domain = "vpc"

  tags = merge(
    { Name = "${var.name}-nat-public-eip" },
    var.tags
  )
}

resource "aws_nat_gateway" "nat_public" {
  allocation_id = aws_eip.nat_public.id
  subnet_id     = var.public_subnet_id

  tags = merge(
    { Name = "${var.name}-nat-public" },
    var.tags
  )
}

resource "aws_nat_gateway" "nat_private" {
  subnet_id     = var.private_subnet_id
  connectivity_type = "private"
  tags = merge(
    { Name = "${var.name}-nat-private" },
    var.tags
  )
}