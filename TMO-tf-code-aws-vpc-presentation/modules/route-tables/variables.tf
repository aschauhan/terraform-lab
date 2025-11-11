variable "vpc_id" {}
variable "name" {}
variable "igw_id" {}
variable "nat_public_id" {}
variable "nat_private_id" {}
variable "public_subnet_ids" {}
variable "private_subnet_ids" {}
variable "nonroutable_subnet_ids" {}
variable "tags" {
  description = "Tags to apply to route table resources"
  type        = map(string)
  default     = {}
}
  # NEWly added tags below
variable "application_ou_name" { type = string }
variable "environment" { type = string }
variable "region" { type = string }
variable "base_tags" { type = map(string) }
#variable "vpc_id" { type = string }