terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.0"
    }
  }
}

# ---------------- VPC ----------------
resource "aws_vpc" "this" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name        = "${var.name}-vpc"
    Environment = var.environment
    Region      = var.region
  }
}

# ---------------- Internet Gateway ----------------
resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id
  tags = {
    Name = "${var.name}-igw"
  }
}

# ---------------- Derived Subnet CIDRs ----------------
# Generate subnet CIDRs automatically
locals {
  public_subnet_cidrs  = [for i in range(var.number_of_azs) : cidrsubnet(var.vpc_cidr, 8, i)]
  private_subnet_cidrs = [for i in range(var.number_of_azs) : cidrsubnet(var.vpc_cidr, 8, i + var.number_of_azs)]
}

# ---------------- Public Subnets ----------------
resource "aws_subnet" "public" {
  count = var.number_of_azs
  vpc_id            = aws_vpc.this.id
  cidr_block        = local.public_subnet_cidrs[count.index]
  availability_zone = element(var.azs, count.index)
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.name}-public-${count.index}"
    Tier = "Public"
  }
}

# ---------------- Private Subnets ----------------
resource "aws_subnet" "private" {
  count = var.number_of_azs
  vpc_id            = aws_vpc.this.id
  cidr_block        = local.private_subnet_cidrs[count.index]
  availability_zone = element(var.azs, count.index)

  tags = {
    Name = "${var.name}-private-${count.index}"
    Tier = "Private"
  }
}

# ---------------- Route Tables ----------------
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this.id
  }
  tags = {
    Name = "${var.name}-public-rt"
  }
}

resource "aws_route_table_association" "public" {
  count = var.number_of_azs
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.this.id
  tags = {
    Name = "${var.name}-private-rt"
  }
}

resource "aws_route_table_association" "private" {
  count = var.number_of_azs
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private.id
}
