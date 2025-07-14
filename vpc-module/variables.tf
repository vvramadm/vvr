
variable "projcet_name" {

  default = "expense"
}

variable "environment" {

  default = "dev"
}

variable "enable_dns_hostnames" {
  default = true
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}
variable "common_tags" {
  default = {
    project     = "expense"
    terraform   = "true"
    environment = "dev"
  }
}

variable "tags" {
  default = {}
}

variable "igw_tags" {
  default = {}
}

variable "public_subnet_cidrs" {
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet_cidrs" {
  default = ["10.0.11.0/24", "10.0.12.0/24"]
}

variable "database_subnet_cidrs" {
  default = ["10.0.21.0/24", "10.0.22.0/24"]
}

variable "db_subnet_group_tags" {

  default = {}
}


variable "public_route_table_tags" {
 default = "public"
}