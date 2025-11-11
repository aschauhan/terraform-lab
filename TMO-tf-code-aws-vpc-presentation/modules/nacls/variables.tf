variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "vpc_cidr" {
  description = "Primary VPC CIDR block"
  type        = string
}

variable "name" {
  description = "Environment or project name"
  type        = string
}

variable "public_subnet_map" {
  description = "Map of public subnet names to subnet IDs"
  type        = map(string)
}

variable "private_subnet_map" {
  description = "Map of private subnet names to subnet IDs"
  type        = map(string)
}

variable "nonroutable_subnet_map" {
  description = "Map of non-routable subnet names to subnet IDs"
  type        = map(string)
}

variable "tags" {
  description = "Tags to apply to all NACLs"
  type        = map(string)
  default     = {}
}

  # NEWly added tags below
variable "application_ou_name" { type = string }
variable "environment" { type = string }
variable "region" { type = string }
variable "base_tags" { type = map(string) }
#variable "vpc_id" { type = string }