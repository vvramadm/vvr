variable "project_name" {
  
}

variable "environment" {
  
}
variable "sg_name" {
  default = {}
}
variable "sg_tags" {
  default = {}
}
variable "vpc_id" {

}

variable "common_tags"{
default = {
 Project = "expense"
 Environment = "dev"
 Terraform = "true"

}
}
  
