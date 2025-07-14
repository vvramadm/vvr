data "aws_ssm_parameter" "vpc_id"{
    name ="/${var.project_name}/${var.environment}/vpc_id"
  
 }

 data "aws_ssm_parameter" "mysql_sg_id" {
     name ="/${var.project_name}/${var.environment}/mysql_sg_id"
    
    depends_on = [ aws_ssm_parameter.mysql_sg_id ]
 }

  data "aws_ssm_parameter" "backend_sg_id" {
      name ="/${var.project_name}/${var.environment}/backend_sg_id"
   
   depends_on = [ aws_ssm_parameter.backend_sg_id ]

  }

 data "aws_ssm_parameter" "frontend_sg_id" {
     name ="/${var.project_name}/${var.environment}/frontend_sg_id"
  depends_on = [aws_ssm_parameter.frontend_sg_id  ]
 }

 data "aws_ssm_parameter" "bastion_sg_id" {
     name ="/${var.project_name}/${var.environment}/bastion_sg_id"
     depends_on = [ aws_ssm_parameter.bastion_sg_id ]
 }

 data "aws_ssm_parameter" "ansible_sg_id" {
     name ="/${var.project_name}/${var.environment}/ansible_sg_id"
     depends_on = [ aws_ssm_parameter.ansible_sg_id ]
 }
