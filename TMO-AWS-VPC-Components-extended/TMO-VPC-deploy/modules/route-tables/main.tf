resource "aws_route_table" "public" {
  vpc_id = var.vpc_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.igw_id
  }
  tags = merge(
    {
      Name = "${var.name}-public-rt"
    },
    var.tags
  )
}

resource "aws_route_table_association" "public" {
  count          = length(var.public_subnet_ids)
  subnet_id      = var.public_subnet_ids[count.index]
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table" "private" {
  vpc_id = var.vpc_id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = var.nat_public_id
  }
  tags = merge(
    {
      Name = "${var.name}-private-rt"
    },
    var.tags
  )
}

resource "aws_route_table_association" "private" {
  count          = length(var.private_subnet_ids)
  subnet_id      = var.private_subnet_ids[count.index]
  route_table_id = aws_route_table.private.id
}

# Non-routable route table
resource "aws_route_table" "nonroutable" {
  vpc_id = var.vpc_id

  route {
    cidr_block     = "10.0.0.0/8"
    nat_gateway_id = var.nat_private_id
  }

  tags = merge(
    {
      Name = "${var.name}-nonroutable-rt"
    },
    var.tags
  )
}

resource "aws_route_table_association" "nonroutable" {
  count          = length(var.nonroutable_subnet_ids)
  subnet_id      = var.nonroutable_subnet_ids[count.index]
  route_table_id = aws_route_table.nonroutable.id
}