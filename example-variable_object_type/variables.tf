variable "region" {
  default = "ap-south-1"

}
variable "vpc_config" {
  description = "VPC configuration using object type"
  type = object({
    cidr_block           = string
    enable_dns_hostnames = bool
    enable_dns_support   = bool
    tags                 = map(string)
  })

  default = {
    cidr_block           = "10.0.0.0/16"
    enable_dns_support   = true
    enable_dns_hostnames = true
    tags = {
      Name        = "demo-vpc"
      Environment = "dev"
    }
  }
}