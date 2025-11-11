variable "vpc_id" {}
variable "name" {}
variable "public_subnet_id" {}
variable "private_subnet_id" {}
variable "tags" {
  description = "Tags to apply to gateway resources"
  type        = map(string)
  default     = {}
}
 # NEWly added tags below
variable "application_ou_name" { type = string }
variable "environment" { type = string }
variable "region" { type = string }
variable "base_tags" { type = map(string) }
#variable "vpc_id" { type = string }
