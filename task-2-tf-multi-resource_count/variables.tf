variable "region" {
  description = "value for region"
  type        = string
  default     = "ap-south-1"

}

variable "ec2_config" {
  type = list(object({
    ami           = string
    instance_type = string
  }))
}