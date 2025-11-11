resource "aws_internet_gateway" "igw" {
  vpc_id = var.vpc_id

  tags = merge(
  {
    Name                  = "${var.application_ou_name}-${var.environment}-igw-${var.region}"
    "Resource Type"       = "igw"
    "Creation Date"       = timestamp()
    "Environment"         = var.environment
    "Application ou name" = var.application_ou_name
    "Created by"          = "Cloud Network Team"
    "Region"              = var.region
  },var.base_tags
  )
}

resource "aws_eip" "nat_public" {
  domain = "vpc"

  tags = merge(
  {
    Name                  = "${var.application_ou_name}-${var.environment}-eip-public-${var.region}"
    "Resource Type"       = "eip"
    "Creation Date"       = timestamp()
    "Environment"         = var.environment
    "Application ou name" = var.application_ou_name
    "Created by"          = "Cloud Network Team"
    "Region"              = var.region
  },var.base_tags
  )
}

resource "aws_nat_gateway" "nat_public" {
  allocation_id = aws_eip.nat_public.id
  subnet_id     = var.public_subnet_id

  tags = merge(
  {
    Name                  = "${var.application_ou_name}-${var.environment}-public-nat-${var.region}"
    "Resource Type"       = "nat"
    "Creation Date"       = timestamp()
    "Environment"         = var.environment
    "Application ou name" = var.application_ou_name
    "Created by"          = "Cloud Network Team"
    "Region"              = var.region
  },var.base_tags
  )
}

resource "aws_nat_gateway" "nat_private" {
  subnet_id     = var.private_subnet_id
  connectivity_type = "private"
  tags = merge(
  {
    Name                  = "${var.application_ou_name}-${var.environment}-private-nat-${var.region}"
    "Resource Type"       = "nat"
    "Creation Date"       = timestamp()
    "Environment"         = var.environment
    "Application ou name" = var.application_ou_name
    "Created by"          = "Cloud Network Team"
    "Region"              = var.region
  },var.base_tags
  )
}