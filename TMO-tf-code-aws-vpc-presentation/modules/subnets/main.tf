resource "aws_subnet" "public" {
  count                   = length(var.azs)
  vpc_id                  = var.vpc_id
  cidr_block              = var.public_subnet_cidrs[count.index]
  availability_zone       = var.azs[count.index]
  map_public_ip_on_launch = true
  tags = merge(
  {
    Name                  = "${var.application_ou_name}-${var.environment}-subnet-${var.region}"
    "Resource Type"       = "subnet"
    "Creation Date"       = timestamp()
    "Environment"         = var.environment
    "Application ou name" = var.application_ou_name
    "Created by"          = "Cloud Network Team"
    "Region"              = var.region
  },var.base_tags
  )
}

resource "aws_subnet" "private" {
  count             = length(var.azs)
  vpc_id            = var.vpc_id
  cidr_block        = var.private_subnet_cidrs[count.index]
  availability_zone = var.azs[count.index]
  tags = merge(
  {
    Name                  = "${var.application_ou_name}-${var.environment}-subnet-${var.region}"
    "Resource Type"       = "subnet"
    "Creation Date"       = timestamp()
    "Environment"         = var.environment
    "Application ou name" = var.application_ou_name
    "Created by"          = "Cloud Network Team"
    "Region"              = var.region
  },var.base_tags
  )
}

resource "aws_subnet" "nonroutable" {
  count             = length(var.azs)
  vpc_id            = var.vpc_id
  cidr_block        = var.nonroutable_subnet_cidrs[count.index]
  availability_zone = var.azs[count.index]
  tags = merge(
  {
    Name                  = "${var.application_ou_name}-${var.environment}-subnet-${var.region}"
    "Resource Type"       = "subnet"
    "Creation Date"       = timestamp()
    "Environment"         = var.environment
    "Application ou name" = var.application_ou_name
    "Created by"          = "Cloud Network Team"
    "Region"              = var.region
  },var.base_tags
  )
}


# Additional CIDR subnets
resource "aws_subnet" "additional" {
  count             = length(var.additional_subnet_cidrs)
  vpc_id            = var.vpc_id
  cidr_block        = var.additional_subnet_cidrs[count.index]
  availability_zone = element(var.azs, count.index % length(var.azs))

  tags = merge(
    {
      Name = "${var.name}-additional-${count.index}"
    },
    var.tags
  )
}