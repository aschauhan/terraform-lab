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