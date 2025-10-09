variable "region" {
    description = "value for region"
    type = string
    default     = "ap-south-1"
  
}

variable "aws_instance_type" {
    description = "what type of ec2 instace want to provision  give the sizing"
    type = string
    default = "t2.micro"
}


variable "ami" {
  description = "AMI ID to use for EC2 instance"
  type        = string
  default     = "ami-02d26659fd82cf299"
}  
