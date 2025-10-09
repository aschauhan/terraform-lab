# ec2_config = [{
#   ami           = "ami-02d26659fd82cf299" # Ubuntu Linux
#   instance_type = "t3.micro"
#   }, {

#   ami           = "ami-01b6d88af12965bb6" #Amazone Linux Image
#   instance_type = "t3.micro"

# }]

ec2_map = {
  "ubuntu" = {
       ami           = "ami-02d26659fd82cf299" # Ubuntu Linux
       instance_type = "t3.micro"
  }, 
  "amazone-linux" = {
        ami           = "ami-01b6d88af12965bb6" #Amazone Linux Image
       instance_type = "t3.micro"

  }
}