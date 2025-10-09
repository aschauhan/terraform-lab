terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.12.0"
    }
  }
}
# provider "aws" {
#   region = "us-east-1"
# }


provider "aws" {
   region = "ap-south-1"
 }

resource "aws_vpc" "labvpc" {
  cidr_block = "10.0.0.0/16"
  
  tags = {
    Name = "labvpc"
  }
}

# Public subnet
resource "aws_subnet" "subnet-pub" {
  vpc_id     = aws_vpc.labvpc.id
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet"
  }
}

# Private subnet
resource "aws_subnet" "subnet-pvt" {
  vpc_id     = aws_vpc.labvpc.id
  cidr_block = "10.0.2.0/24"

  tags = {
    Name = "pvt-subnet"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.labvpc.id
  tags = {
    Name = "labvpc-igw"
  }
}


############### Public Route Table ###############

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.labvpc.id

  tags = {
    Name = "public_rt"
  }
}

# Explicit route for 0.0.0.0/0
resource "aws_route" "public_internet_access" {
  route_table_id         = aws_route_table.public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}





# Private Route Table
resource "aws_route_table" "pvt_rt" {
  vpc_id = aws_vpc.labvpc.id
  tags = {
    Name = "private_rt"
  }
}

#route table Associations
resource "aws_route_table_association" "pubrt_association" {
  subnet_id      = aws_subnet.subnet-pub.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "pvtrt_association" {
  subnet_id      = aws_subnet.subnet-pvt.id
  route_table_id = aws_route_table.pvt_rt.id
}


### Creating security group

resource "aws_security_group" "linux_sg" {
  name        = "linux-sg"
  description = "Allow SSH"
  vpc_id      = aws_vpc.labvpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "linux-sg"
  }
}

#### Creating ec2 instance

resource "aws_instance" "Linux" {
  # ami                         = "ami-0360c520857e3138f"
  ami                         = "ami-02d26659fd82cf299"
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.subnet-pub.id
  vpc_security_group_ids      = [aws_security_group.linux_sg.id]
  associate_public_ip_address = true
  key_name = "aws-net-course-key"

  tags = {
    Name = "Linux"
  }
}

output "region" {
  value = "ap-south-1"
}

output "instance_id" {
  description = "The ID of the EC2 instance"
  value       = aws_instance.Linux.id
}

output "public_ip" {
  description = "Public IP of the EC2 instance"
  value       = aws_instance.Linux.public_ip
}

output "availability_zone" {
  description = "Availability Zone of the EC2 instance"
  value       = aws_instance.Linux.availability_zone
}