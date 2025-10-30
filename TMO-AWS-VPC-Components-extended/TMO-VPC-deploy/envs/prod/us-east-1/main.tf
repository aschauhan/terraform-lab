provider "aws" {
  region = "us-east-1"
}

# -------------------------
# VPC
# -------------------------
module "vpc" {
  source   = "../../../modules/vpc"
  vpc_cidr = var.vpc_cidr
  name     = var.name
  tags     = merge(local.common_tags, var.tags)
}

# -------------------------
# Subnets
# -------------------------
module "subnets" {
  source                   = "../../../modules/subnets"
  vpc_id                   = module.vpc.vpc_id
  name                     = var.name
  azs                      = var.azs
  public_subnet_cidrs      = var.public_subnet_cidrs
  private_subnet_cidrs     = var.private_subnet_cidrs
  nonroutable_subnet_cidrs = var.nonroutable_subnet_cidrs
  tags                     = merge(local.common_tags, var.tags)
}

# -------------------------
# Gateways (IGW + NATs)
# -------------------------
module "gateways" {
  source            = "../../../modules/gateways"
  vpc_id            = module.vpc.vpc_id
  name              = var.name
  public_subnet_id  = module.subnets.public_subnets[0]
  private_subnet_id = module.subnets.private_subnets[0]
  tags              = merge(local.common_tags, var.tags)
}

# -------------------------
# Route Tables
# -------------------------
module "route_tables" {
  source                 = "../../../modules/route-tables"
  vpc_id                 = module.vpc.vpc_id
  name                   = var.name
  igw_id                 = module.gateways.igw_id
  nat_public_id          = module.gateways.nat_public_id
  nat_private_id         = module.gateways.nat_private_id
  public_subnet_ids      = module.subnets.public_subnets
  private_subnet_ids     = module.subnets.private_subnets
  nonroutable_subnet_ids = module.subnets.nonroutable_subnets
  tags                   = merge(local.common_tags, var.tags)
}

# -------------------------
# Security Groups
# -------------------------
module "security" {
  source = "../../../modules/security"
  vpc_id = module.vpc.vpc_id
  name   = var.name
  tags   = merge(local.common_tags, var.tags)
}

# -------------------------
# DHCP Options
# -------------------------
module "dhcp_options" {
  source               = "../../../modules/dhcp-options"
  vpc_id               = module.vpc.vpc_id
  name                 = var.name
  domain_name          = var.domain_name
  domain_name_servers  = var.domain_name_servers
  ntp_servers          = var.ntp_servers
  netbios_name_servers = var.netbios_name_servers
  netbios_node_type    = var.netbios_node_type
  tags                 = merge(local.common_tags, var.tags)
}