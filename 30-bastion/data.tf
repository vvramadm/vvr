 data "aws_ssm_parameter" "bastion_sg_id" {
     name ="/${var.project_name}/${var.environment}/bastion_sg_id"
     
 }


data "aws_ssm_parameter" "public_subnet_ids" {

     name = "/${var.project_name}/${var.environment}/public_subnet_ids"
     
     }

     
data  "aws_ssm_parameter" "vpc_id" {
    name = "/${var.project_name}/${var.environment}/vpc_id"
}

data "aws_ami" "devops" {

    most_recent = true
    owners = [222352935292] # aws account id
    filter {
      
      name = "name"
      values = ["test5555"]
    }
    filter {
      name = "root-device-type"
      values = ["ebs"]
    }

    filter {
      name = "virtualization-type"
      values = ["hvm"]
    }
}