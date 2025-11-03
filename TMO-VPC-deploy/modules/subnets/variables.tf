variable "vpc_id" {}
variable "name" {}
variable "azs" {
  type = list(string)
}

variable "public_subnet_cidrs" {
  type = list(string)
}

variable "private_subnet_cidrs" {
  type = list(string)
}

variable "nonroutable_subnet_cidrs" {
  type = list(string)
}

# New: subnets carved from additional CIDRs
variable "additional_subnet_cidrs" {
  description = "List of CIDRs for subnets carved from additional VPC CIDRs"
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "Tags to apply to subnets"
  type        = map(string)
  default     = {}
}