variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "additional_cidrs" {
  description = "Additional CIDR blocks for the VPC"
  type        = list(string)
  default     = []
}

variable "name" {
  description = "Name prefix for resources"
  type        = string
}

variable "azs" {
  description = "List of availability zones"
  type        = list(string)
}

variable "public_subnet_cidrs" {
  description = "CIDRs for public subnets"
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "CIDRs for private subnets"
  type        = list(string)
}

variable "nonroutable_subnet_cidrs" {
  description = "CIDRs for nonroutable subnets"
  type        = list(string)
}

variable "domain_name" {
  type        = string
  description = "Domain name for DHCP options"
}

variable "domain_name_servers" {
  type        = list(string)
  description = "List of DNS servers"
}

variable "ntp_servers" {
  type        = list(string)
  description = "List of NTP servers"
}

variable "netbios_name_servers" {
  type        = list(string)
  description = "List of NetBIOS name servers"
  default     = []
}

variable "netbios_node_type" {
  type        = number
  description = "NetBIOS node type (1,2,4,8)"
  default     = 2
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to resources"
  default     = {}
}

variable "additional_subnet_cidrs" {
  description = "Subnets carved from additional CIDRs"
  type        = list(string)
  default     = []
}

variable "application_ou_name" { type = string }
variable "environment" { type = string }
variable "region" { type = string }

variable "base_tags" {
  type    = map(string)
  default = { "Developer" = "Cloud Network Devops Team" }
}

# variable "base_2_tags" {
#   type    = map(string)
#   default = { "suggested_by" = "Terraform Team" }
# }