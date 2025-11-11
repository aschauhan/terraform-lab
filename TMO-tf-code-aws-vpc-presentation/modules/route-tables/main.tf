# -------------------------
# Public Route Table (shared)
# -------------------------
resource "aws_route_table" "public" {
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.igw_id
  }

  tags = merge(
  {
    Name                  = "${var.application_ou_name}-${var.environment}-public-rt-${var.region}"
    "Resource Type"       = "routing-table"
    "Creation Date"       = timestamp()
    "Environment"         = var.environment
    "Application ou name" = var.application_ou_name
    "Created by"          = "Cloud Network Team"
    "Region"              = var.region
  },var.base_tags
  )
}

resource "aws_route_table_association" "public" {
  count          = length(var.public_subnet_ids)
  subnet_id      = var.public_subnet_ids[count.index]
  route_table_id = aws_route_table.public.id
}

# -------------------------
# Private Route Tables (one per subnet)
# -------------------------
resource "aws_route_table" "private" {
  count  = length(var.private_subnet_ids)
  vpc_id = var.vpc_id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = var.nat_public_id
  }

  tags = merge(
  {
    Name                  = "${var.application_ou_name}-${var.environment}-private-rt-${var.region}"
    "Resource Type"       = "routing-table"
    "Creation Date"       = timestamp()
    "Environment"         = var.environment
    "Application ou name" = var.application_ou_name
    "Created by"          = "Cloud Network Team"
    "Region"              = var.region
  },var.base_tags
  )
}

resource "aws_route_table_association" "private" {
  count          = length(var.private_subnet_ids)
  subnet_id      = var.private_subnet_ids[count.index]
  route_table_id = aws_route_table.private[count.index].id
}

# -------------------------
# Non-Routable Route Tables (one per subnet)
# -------------------------
resource "aws_route_table" "nonroutable" {
  count  = length(var.nonroutable_subnet_ids)
  vpc_id = var.vpc_id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = var.nat_private_id
  }

  route {
    cidr_block     = "10.0.0.0/8"
    nat_gateway_id = var.nat_private_id
  }


  tags = merge(
  {
    Name                  = "${var.application_ou_name}-${var.environment}-nonroutable-rt-${var.region}"
    "Resource Type"       = "routing-table"
    "Creation Date"       = timestamp()
    "Environment"         = var.environment
    "Application ou name" = var.application_ou_name
    "Created by"          = "Cloud Network Team"
    "Region"              = var.region
  },var.base_tags
  )
}

resource "aws_route_table_association" "nonroutable" {
  count          = length(var.nonroutable_subnet_ids)
  subnet_id      = var.nonroutable_subnet_ids[count.index]
  route_table_id = aws_route_table.nonroutable[count.index].id
}