variable "name" {
  type = string
  default = "example-vpc"
}

variable "environment" {
  type = string
}

variable "azs" {
  type = list(string)
}
