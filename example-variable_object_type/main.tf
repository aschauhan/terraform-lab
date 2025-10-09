terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.12.0"
    }
  }
}
provider "aws" {
  region = var.region
}

# Create VPC using object variable
resource "aws_vpc" "myvpc" {
  cidr_block           = var.vpc_config.cidr_block
  enable_dns_support   = var.vpc_config.enable_dns_support
  enable_dns_hostnames = var.vpc_config.enable_dns_hostnames
  tags                 = var.vpc_config.tags
}

output "vpc_id" {
  value = aws_vpc.myvpc.id
  }
