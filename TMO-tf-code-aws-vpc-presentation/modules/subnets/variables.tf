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

# NEWly added tags below
variable "application_ou_name" { type = string }
variable "environment" { type = string }
variable "region" { type = string }
variable "base_tags" { type = map(string) }
#variable "vpc_id" { type = string }