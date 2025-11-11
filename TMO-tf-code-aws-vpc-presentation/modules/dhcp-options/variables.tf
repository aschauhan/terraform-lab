variable "vpc_id" {
  description = "The VPC ID to associate the DHCP options with"
}

variable "name" {
  description = "Name prefix for resources"
  type        = string
}

variable "domain_name" {
  description = "The domain name to assign to instances"
  type        = string
}

variable "domain_name_servers" {
  description = "List of DNS servers"
  type        = list(string)
}

variable "ntp_servers" {
  description = "List of NTP servers"
  type        = list(string)
}

variable "netbios_name_servers" {
  description = "List of NetBIOS name servers"
  type        = list(string)
  default     = []
}

variable "netbios_node_type" {
  description = "NetBIOS node type (1,2,4,8)"
  type        = number
  default     = 2
}

variable "tags" {
  description = "Additional tags to apply"
  type        = map(string)
  default     = {}
}

  # NEWly added tags below
variable "application_ou_name" { type = string }
variable "environment" { type = string }
variable "region" { type = string }
variable "base_tags" { type = map(string) }
#variable "vpc_id" { type = string }