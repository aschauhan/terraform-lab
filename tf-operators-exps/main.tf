terraform {}



#Number List
variable "num_list" {
  type    = list(number)
  default = [1, 2, 3, 4, 5]
}

# Object list of person
variable "person_list" {
  type = list(object({
    fname = string
    lname = string
  }))
  default = [{
    fname = "raju"
    lname = "rastogi"

    }, {
    fname = "ravi"
    lname = "sharma"
  }]
}

variable "map_list" {
  type = map(number)
  default = {
    "one"   = 1
    "two"   = 2
    "three" = 3
  }

}

#Calculations
locals {
  
  mul = 2 * 4
  add = 2 + 2
  eq  = 2 != 3

# Double the value which is mentioned in num_list variable

double = [for num in var.num_list : num * 2]

# odd number only to be store in variable from num_list

odd = [for num in var.num_list : num if num%2 !=0]

fname_list = [for person in var.person_list : person.fname]
lname_list  = [for person in var.person_list : person.lname]

# work with map type variable
map_value = [ for key, value in var.map_list: value]

map_key = [ for key, value in var.map_list: key]

double_map = { for key, value in var.map_list:  key=>value * 2 }
}


####################### Following is the diffrent output statment to pring diffrent variable values ############

# printing values under variable num_list
# output "name" {
#     value = var.num_list
  
# }


# # printing values store in double variable 
# output "name" {
#     value = local.double
  
# }

# #printing values store in odd variable 
# output "name" {
#     value = local.odd
  
# }


 #printing values store in person_list variable 
#  output "name" {
#      value = local.fname_list
#      count = 2
  
#  }
# output "lname" {
#      value = local.lname_list
  
#  }



#  #printing values store in map variable 
#  output "name" {
#      value = local.map_value
  
#  }

#   #printing values store in map variable 
#  output "key_name" {
#      value = local.map_key
  
#  }

 #printing values store in double_map variable 
 output "key_name" {
     value = local.double_map
  
 }