variable "project_name" {

    default = "vvr"
  
}
variable "environment" {
  default = "dev"
}
variable "instance_type" {
  type = string
  default = "t3.micro"
}
variable "key_name" {
  
  default     = "LLkey"
  

}