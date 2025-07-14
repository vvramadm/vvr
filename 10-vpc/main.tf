module "vpc" {
 source = "../terraform-aws-vpc"
 #source = "git::https://github.com/vvramadm/terraform-aws-vpc.git?ref=main"
  
  project_name          = var.project_name
  environment           = var.environment 
  enable_dns_hostnames = var.enable_dns_hostnames
  common_tags           = var.common_tags
  vpc_cidr              = var.vpc_cidr
  #az_zones              = local.az_zones
  public_subnet_cidrs   = var.public_subnet_cidrs
  private_subnet_cidrs  = var.private_subnet_cidrs
  database_subnet_cidrs = var.database_subnet_cidrs
  is_peering_required   = true

}


















