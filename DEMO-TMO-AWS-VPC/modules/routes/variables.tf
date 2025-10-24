variable "vpc_id" { type = string }
variable "igw_id" { type = string }
variable "public_subnet_ids" { type = list(string) }
variable "private_subnet_ids" { type = list(string) }
variable "non_routable_subnet_ids" { type = list(string) }
variable "nat_gateway_ids" { type = list(string) }
variable "availability_zones" { type = list(string) }