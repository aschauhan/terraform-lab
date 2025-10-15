variable "name" {
  type = string
}

variable "environment" {
  type = string
}

variable "region" {
  type = string
}

variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "number_of_azs" {
  type    = number
  default = 2
}

variable "azs" {
  type    = list(string)
  default = []
}
