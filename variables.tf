
# variable region {
#     type = string
#     default = "us-east-1"
# }

variable "sg_group" {
  type    = string
  default = "sg_gr"
}

variable "sg_region" {
  type    = string
  default = "allow_ssh_security_group"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  default = "10.0.1.0/24"
}

variable "private_subnet_cidr" {

  default = "10.0.2.0/24"
}
variable "instance_type" {
  default = []
}

variable "location" {
  default = []
}
 