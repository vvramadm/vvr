locals {
  resource_name="${var.project_name}-${var.environment}"
  vpc_id = data.aws_ssm_parameter.vpc_id.value
  ami_id = data.aws_ami.devops.id
  bastion_sg_id = data.aws_ssm_parameter.bastion_sg_id.value
  public_subnet_id =split(",",data.aws_ssm_parameter.public_subnet_ids.value)[0]
}