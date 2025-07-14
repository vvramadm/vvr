variable "project_name" {

    default = "vvr"
  
}
variable "environment" {
  default = "dev"
}


variable "key_name" {
  
  default     = "LLkey"
  

}
variable "backend_tags" {
  
  default = {
    component = "backend"
  }
}

variable "common_tags" {
  default = {
    Project = "vvr"
    Terraform = "true"
    Environment = "dev"
  }

}

variable "domain_name" {
  
  default = "ramops.online"
}

# variable "instance_count" {
#   type = number
  
# }

variable "name_prefix" {
  type = string
  default = "vvr"
}

# variable "ec2_instance_ids" {
#   type = list(string)
#   description = "List of EC2 instance IDs"
# }

# variable "target_group_arn" {
#   type = string
#   description = "ARN of the target group"
# }

variable "instances" {
  type        = map
  default     = {
    
    vvr-dev-backend-1 = "t3.micro"
    vvr-dev-backend-2 = "t3.micro"
    vvr-dev-backend-3 = "t3.micro"
    vvr-dev-backend-4 = "t3.micro"
    vvr-dev-backend-5 = "t3.micro"
    vvr-dev-backend-6 = "t3.micro"
    
  }
}