terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.12.0"
    }
  }
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

# # Public Route Table
# resource "aws_route_table" "public_rt" {
#   vpc_id = aws_vpc.labvpc.id

#   route {
#     cidr_block = "0.0.0.0/0"
#     gateway_id = aws_internet_gateway.igw.id
#   }

#   tags = {
#     Name = "public_rt"
#   }
# }

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

# Associations
resource "aws_route_table_association" "pubrt_association" {
  subnet_id      = aws_subnet.subnet-pub.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "pvtrt_association" {
  subnet_id      = aws_subnet.subnet-pvt.id
  route_table_id = aws_route_table.pvt_rt.id
}
