variable "project_name" {
    default = "vvr"
}

variable "environment" {
    default = "dev"
}

variable "common_tags" {
    default = {
        Project = "vvr"
        Environment = "dev"
        Terraform = "true"
    }
}


variable "zone_id" {
    default = "Z09407641B27Z7IYQWK9Y"
}

variable "zone_name" {
    default = "ramops.online"
}

variable "domain_name" {
    default = "ramops.online"
}