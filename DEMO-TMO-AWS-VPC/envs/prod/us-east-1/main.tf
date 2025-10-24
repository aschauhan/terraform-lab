provider "aws" {
  region = var.region
}
data "aws_availability_zones" "available" {
  state = "available"
}
module "vpc" {
  source    = "../../../modules/vpc"
  vpc_cidr  = var.vpc_cidr
  vpc_name  = "${var.env}-vpc"
}
module "igw" {
  source  = "../../../modules/igw"
  vpc_id  = module.vpc.vpc_id
}
module "subnets" {
  source             = "../../../modules/subnets"
  env                = var.env
  vpc_id             = module.vpc.vpc_id
  vpc_cidr           = var.vpc_cidr
  availability_zones = data.aws_availability_zones.available.names
}
module "nat" {
  source             = "../../../modules/nat"
  public_subnet_ids  = module.subnets.public_subnet_ids
  availability_zones = data.aws_availability_zones.available.names
}
module "routes" {
  source                  = "../../../modules/routes"
  vpc_id                  = module.vpc.vpc_id
  igw_id                  = module.igw.igw_id
  public_subnet_ids       = module.subnets.public_subnet_ids
  private_subnet_ids      = module.subnets.private_subnet_ids
  non_routable_subnet_ids = module.subnets.non_routable_subnet_ids
  nat_gateway_ids         = module.nat.nat_gateway_ids
  availability_zones      = data.aws_availability_zones.available.names
}