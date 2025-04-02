variable "sg_group" {
  type    = string
  default = "sg_gr"
}

variable "sg_region" {
  type    = string
  default = "allow_ssh_security_group"
}

variable "vpc_cidr" {
  default = []
}

variable "public_subnet_cidr" {
  default = []
}

variable "public_subnet_cidr_1" {
  default = []
}


variable "private_subnet_cidr" {
  default = []
}

variable "instance_type" {
   default = []
}

variable "region" {
  default = []
}

variable "name_prefix" {
  default = []
  
}

variable "image_id" {
  default = []
  
}
variable "key_name" {
  default = []
  
}