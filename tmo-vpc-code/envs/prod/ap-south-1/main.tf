module "vpc" {
  source = "../../../modules/vpc"

  name        = var.name
  environment = var.environment
  region      = "ap-south-1"
  cidr_block  = "10.0.0.0/16"
  public_subnets_cidrs = ["10.0.1.0/24","10.0.2.0/24"]
  azs = var.azs
}

output "vpc_id" {
  value = module.vpc.vpc_id
}
