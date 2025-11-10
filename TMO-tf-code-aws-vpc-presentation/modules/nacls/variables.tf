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