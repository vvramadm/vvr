variable "project_name"{
    default = "vvr"
  
}

variable "environment"{
    default = "dev"
  
}
variable "mysql_sg_tags"{
    default = {
        component = "mysql"
        }
      
}
variable "backend_tags"{
    default = {
        component= "backend"
    }
  
}

variable "frontend_tags"{
    default = {

        component = "frontend"
    }
  
}

variable "bastion_sg_tags"{
    default = {

        component = "bastion"
    }
  
}

variable "ansible_sg_tags"{
    default = {
        component = "ansible"
    }
  
}
variable "app_alb_sg_tags"{
    default = {
        component = "app_alb"
    }
  
}

variable "web_alb_sg_tags"{
    default = {
        component = "web_alb"
    }
  
}

variable "common_tags"{
    default = {

        Project = "expense"
        Environment = "dev"
        Terraform = "true"
    }
}

variable "sg_name"{

    default = "mysql"
}

variable "vpn_sg_tags"{

    default = "vpn"
}

/* variable "vpc_id"{
  vpc_id = local.vpc_id
} */