variable "region" {
  description = "value for region"
  type        = string
  default     = "ap-south-1"

}

variable "aws_instance_type" {
  description = "what type of ec2 instace want to provision  give the sizing"
  type        = string
  validation {
    condition = var.aws_instance_type == "t2.micro" || var.aws_instance_type == "t3.micro"
    # error_message = "Only t2 or t3 micro Ec2 instance allowed"
    error_message = "❌ INVALID INSTANCE TYPE ❌ → Only t2.micro or t3.micro are allowed! "

  }
}


variable "ami" {
  description = "AMI ID to use for EC2 instance"
  type        = string
  default     = "ami-02d26659fd82cf299"
}
