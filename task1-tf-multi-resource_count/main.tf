terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.12.0"
    }
  }
}

provider "aws" {
  # Configuration options
  region = var.region
}
locals {
  project = "project-01"
}

resource "aws_vpc" "my-vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "${local.project}-vpc"

  }
}


resource "aws_subnet" "main" {
  vpc_id     = aws_vpc.my-vpc.id
  cidr_block = "10.0.${count.index}.0/24"
  count      = 2
  tags = {
    Name = "${local.project}-subnet-${count.index}"
  }
}

# Creating EC2 instance using same code in both subnet

resource "aws_instance" "demo-01" {
  ami           = "ami-02d26659fd82cf299"
  instance_type = "t3.micro"
  count         = 4
  subnet_id     = element(aws_subnet.main[*].id, count.index % length(aws_subnet.main))

  tags = {
    Name = "${local.project}-instance-${count.index}"

  }
}

   