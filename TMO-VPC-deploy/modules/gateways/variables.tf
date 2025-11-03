variable "vpc_id" {}
variable "name" {}
variable "public_subnet_id" {}
variable "private_subnet_id" {}
variable "tags" {
  description = "Tags to apply to gateway resources"
  type        = map(string)
  default     = {}
}