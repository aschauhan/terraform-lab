variable "vpc_cidr" {}
variable "name" {}
variable "tags" {
  description = "Tags to apply to the VPC"
  type        = map(string)
  default     = {}
}
variable "additional_cidrs" {
  description = "List of additional CIDR blocks to associate with the VPC"
  type        = list(string)
  default     = []
}
# NEWly added tags below
variable "application_ou_name" { type = string }
variable "environment" { type = string }
variable "region" { type = string }
variable "base_tags" { type = map(string) }


## Testing Tag ##### 
# variable "base_2_tags" {
#   type    = map(string)
#   default = { "suggested_by" = "Terraform Team" }
# }