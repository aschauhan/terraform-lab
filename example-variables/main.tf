
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.12.0"
    }
  }
}

provider "aws" {
  # Configuration options
  region = var.region
}

resource "aws_instance" "demo-01" {
    ami = var.ami
    instance_type = var.aws_instance_type
    key_name = "aws-net-course-key"
    tags = {
        Name = "My-linux"
    }
  }