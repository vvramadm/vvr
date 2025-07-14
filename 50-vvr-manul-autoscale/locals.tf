# EventBridge scheduled rules
locals {
  cron_out = "cron(30 3 * * ? *)"    # 09:00 IST = 03:30 UTC
  cron_in  = "cron(30 12 * * ? *)"   # 18:00 IST = 12:30 UTC

  resource_name="${var.project_name}-${var.environment}"
  vpc_id = data.aws_ssm_parameter.vpc_id.value
  ami_id = data.aws_ami.devops.id
  backend_sg_id = data.aws_ssm_parameter.backend_sg_id.value
  private_subnet_id = split(",",data.aws_ssm_parameter.private_subnet_ids.value)[0]
   private_subnet_ids = split(",",data.aws_ssm_parameter.private_subnet_ids.value)
  app_alb_listener_arn = data.aws_ssm_parameter.app_alb_listener_arn.value 
}