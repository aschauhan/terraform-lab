variable "vpc_id" {}
variable "region" {}
variable "name" {}
variable "subnet_ids" {
  description = "List of subnet IDs for Interface endpoints (usually private subnets)"
  type        = list(string)
}
variable "security_group_id" {
  description = "Security group to attach to Interface endpoints"
  type        = string
}
variable "route_table_ids" {
  description = "Route tables for Gateway endpoints (e.g., S3)"
  type        = list(string)
}
variable "tags" {
  description = "Tags to apply"
  type        = map(string)
  default     = {}
}