
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
   region =   var.region
}

data "aws_ami" "example" {
   most_recent      = true
   owners           = ["amazon"]

}


resource "aws_instance" "demo-01" {
    ami = data.aws_ami.example.id 
    instance_type = "t2.micro"
    key_name = "aws-net-course-key"
    tags = {
        Name = "My-linux"
    }
  }
#   data "aws_region" "current" {}

## Security group

data "aws_security_group" "selected" {
  # tags = {
  #   mygroup = "web"
  # }
  filter {

    name   = "group-name" 
    values = ["demo"]
}
    }




  output "aws_ami" { 
    value = {
    id  = data.aws_ami.example.id,
    name = data.aws_ami.example.name,
    description = data.aws_ami.example.description
    # region = data.aws_region.current.name
    region = var.region
    security_group = data.aws_security_group.selected.name

    }
    
  }

  
