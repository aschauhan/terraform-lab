provider "aws" {
  region     = "us-east-1"
}

# ---------------- VPC ----------------
module "vpc" {
  source           = "../../../modules/vpc"
  vpc_cidr         = var.vpc_cidr
  additional_cidrs = var.additional_cidrs
  name             = var.name
  tags             = merge(local.common_tags, var.tags)
}

# ---------------- Subnets ----------------
module "subnets" {
  source                   = "../../../modules/subnets"
  vpc_id                   = module.vpc.vpc_id
  name                     = var.name
  azs                      = var.azs
  public_subnet_cidrs      = var.public_subnet_cidrs
  private_subnet_cidrs     = var.private_subnet_cidrs
  nonroutable_subnet_cidrs = var.nonroutable_subnet_cidrs
  additional_subnet_cidrs  = var.additional_subnet_cidrs
  tags                     = merge(local.common_tags, var.tags)

  # 👇 Ensure VPC CIDRs are fully attached before subnets are created
  depends_on = [module.vpc]
}

# ---------------- Gateways ----------------
module "gateways" {
  source            = "../../../modules/gateways"
  vpc_id            = module.vpc.vpc_id
  name              = var.name
  public_subnet_id  = module.subnets.public_subnets[0]
  private_subnet_id = module.subnets.private_subnets[0]
  tags              = merge(local.common_tags, var.tags)

  # 👇 Gateways depend on subnets
  depends_on = [module.subnets]
}

# ---------------- Route Tables ----------------
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

  # 👇 Route tables depend on gateways & subnets
  depends_on = [module.gateways, module.subnets]
}

# ---------------- Security Groups ----------------
module "security" {
  source = "../../../modules/security"
  vpc_id = module.vpc.vpc_id
  name   = var.name
  tags   = merge(local.common_tags, var.tags)

  # 👇 Ensure security resources come after VPC
  depends_on = [module.vpc]
}

# ---------------- DHCP Options ----------------
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

  depends_on = [module.vpc]
}

module "ssm_endpoints" {
  source            = "../../../modules/vpc-endpoints"
  vpc_id            = module.vpc.vpc_id
  region            = "us-east-1"
  name              = var.name
  subnet_ids        = module.subnets.private_subnets
  security_group_id = module.security.endpoints_sg_id
  route_table_ids   = [
    module.route_tables.public_route_table_id,
    module.route_tables.private_route_table_id,
    module.route_tables.nonroutable_route_table_id
  ]
  tags              = merge(local.common_tags, var.tags)

  depends_on = [module.vpc]
}