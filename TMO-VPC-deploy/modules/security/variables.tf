variable "vpc_id" {}
variable "name" {}
variable "tags" {
  description = "Tags to apply to security groups"
  type        = map(string)
  default     = {}
}

variable "endpoint_allowed_cidrs" {
  description = "CIDR blocks allowed to connect to VPC Interface Endpoints"
  type        = list(string)
  default     = []
}


