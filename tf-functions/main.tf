
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.12.0"
    }
  }
}

provider "aws" {
  # Configuration options
  region = var.region
}

locals {
  value = "Hello World"
}

variable "string_list" {
  type    = list(string)
  default = ["serv1", "serv2", "serv3"]

}

output "output" {
  # value = upper(local.value)
  # value = startswith(local.value, "Hello")
    # value = max(1, 2, 3, 4, 7, 0, 6)
    # value = length(var.string_list)
    # value = join(":", var.string_list)
    value = contains(var.string_list, "serv1")
    


}

