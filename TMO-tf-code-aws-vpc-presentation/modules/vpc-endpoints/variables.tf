variable "vpc_id" {
  description = "ID of the VPC where endpoints will be created"
  type        = string
}

# variable "region" {
#   description = "AWS region for endpoint service names"
#   type        = string
# }

variable "name" {
  description = "Environment or project name used for naming resources"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs for Interface endpoints (usually private subnets)"
  type        = list(string)
}

variable "security_group_id" {
  description = "Security group to attach to Interface endpoints"
  type        = string
}

variable "route_table_ids" {
  description = "List of route table IDs for Gateway endpoints (e.g., S3)"
  type        = list(string)
}

variable "tags" {
  description = "Tags to apply to all resources in this module"
  type        = map(string)
  default     = {}
}

  # NEWly added tags below
variable "application_ou_name" { type = string }
variable "environment" { type = string }
variable "region" { type = string }
variable "base_tags" { type = map(string) }
#variable "vpc_id" { type = string }