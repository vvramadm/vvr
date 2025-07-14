
variable "project_name"{

  default = "vvr"
}

variable "environment" {

  default = "dev"
}

variable "enable_dns_hostnames" {
  default = true
}

variable "vpc_cidr" {
  default = "192.168.0.0/16"
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
  default = ["192.168.1.0/24", "192.168.2.0/24","192.168.3.0/24"]
}

variable "private_subnet_cidrs" {
  default = ["192.168.11.0/24", "192.168.12.0/24","192.168.13.0/24"]
}

variable "database_subnet_cidrs" {
  default = ["192.168.21.0/24", "192.168.22.0/24","192.168.23.0/24"]
}

variable "db_subnet_group_tags" {

  default = {}
}


variable "public_route_table_tags" {
  default = "public"
}