# Existing Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = var.vpc_id
  tags = merge(
    {
      Name = "${var.name}-igw"
    },
    var.tags
  )
}

# Elastic IP for public NAT
resource "aws_eip" "nat_public" {
  domain = "vpc"
  tags = merge(
    {
      Name = "${var.name}-nat-public-eip"
    },
    var.tags
  )
}

# Public NAT Gateway (for private subnets)
resource "aws_nat_gateway" "nat_public" {
  allocation_id = aws_eip.nat_public.id
  subnet_id     = var.public_subnet_id
  tags = merge(
    {
      Name = "${var.name}-nat-private"
    },
    var.tags
  )
}

# Elastic IP for private NAT
resource "aws_eip" "nat_private" {
  domain = "vpc"
  tags = merge(
    {
      Name = "${var.name}-nat-private-eip"
    },
    var.tags
  )
}

# Private NAT Gateway (for non-routable subnets)
resource "aws_nat_gateway" "nat_private" {
  allocation_id = aws_eip.nat_private.id
  subnet_id     = var.private_subnet_id
  tags = merge(
    {
      Name = "${var.name}-nat-non-ro-private"
    },
    var.tags
  )
}