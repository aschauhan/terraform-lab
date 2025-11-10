resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = merge(
  {
    Name                  = "${var.application_ou_name}-${var.environment}-vpc-${var.region}"
    "Resource Type"       = "vpc"
    "Creation Date"       = timestamp()
    "Environment"         = var.environment
    "Application ou name" = var.application_ou_name
    "Created by"          = "Cloud Network Team"
    "Region"              = var.region
  },var.base_tags
)
}

# Associate additional CIDRs
resource "aws_vpc_ipv4_cidr_block_association" "additional" {
  for_each   = toset(var.additional_cidrs)
  vpc_id     = aws_vpc.main.id
  cidr_block = each.value
}