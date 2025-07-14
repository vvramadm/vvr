locals {

  resource_name = "${var.project_name}-${var.environment}"
  az_info       = slice(data.aws_availability_zones.available.names, 0, 3)
  az_zones       = slice(data.aws_availability_zones.available.names, 0, 3)
  public_subnet_ids = split(",", data.aws_ssm_parameter.public_subnet_ids.value)
}