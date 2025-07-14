data "aws_availability_zones" "available" {
  state = "available"
}

data "aws_vpc" "default" {
  default = true
}

data "aws_ssm_parameter" "public_subnet_ids" {

     name = "/${var.project_name}/${var.environment}/public_subnet_ids "
     depends_on = [ aws_ssm_parameter.public_subnet_ids ]
     }
