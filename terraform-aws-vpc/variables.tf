
variable "project_name"{

   
    default= {}
}

variable "environment" {
  
  default = {}
}

variable "enable_dns_hostnames" {
  default = true
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}
variable "common_tags" {
  default = {}
}

variable "tags" {
   default = {}
}

 variable "igw_tags" {
 default = {}
} 

variable "public_subnet_cidrs" {
  type = list
  validation {
    condition = length(var.public_subnet_cidrs)==3
    error_message = "please provide 3 valid subnet cidr"
  }
}

variable "private_subnet_cidrs" {
  type = list
  validation {
    condition = length(var.private_subnet_cidrs)==3
    error_message = "please provide 3 valid subnet cidr"
  }
}

variable "database_subnet_cidrs" {
  type = list
  validation {
    condition = length(var.database_subnet_cidrs )==3
    error_message = "please provide 3 valid subnet cidr"
  }
}

variable "db_subnet_group_tags" {

 default =  {}
 }



 variable "public_route_table_tags" {
   default = {}
}

variable "private_route_table_tags" {
  default = {}
 }
variable "database_route_table_tags" {
 default = {}
 }

variable "is_peering_required" {
  type = bool
   default = false
}

 variable "vpc_peering_tags" {
   default = {}
  
 }