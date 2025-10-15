module "vpc" {
  source = "../../../modules/vpc"

  name          = var.name
  environment   = var.environment
  region        = "ap-south-1"
  vpc_cidr      = "10.0.0.0/16"
  number_of_azs = 2
  azs           = ["ap-south-1a", "ap-south-1b"]
}

output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnet_cidrs" {
  value = module.vpc.public_subnet_cidrs
}

output "private_subnet_cidrs" {
  value = module.vpc.private_subnet_cidrs
}
