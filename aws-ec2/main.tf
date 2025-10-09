
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
    ami = "ami-02d26659fd82cf299"
    instance_type = "t2.micro"
    key_name = "aws-net-course-key"
    tags = {
        Name = "My-linux"
    }
  }