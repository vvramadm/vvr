module "vpc" {
    #source = "../vpc"
    source = "git::https://github.com/vvramadm/terraform-.git?ref=main"
    projcet_name = var.projcet_name
    environment = var.environment
    common_tags = var.common_tags
    vpc_cidr = var.vpc_cidr
    public_subnet_cidrs = var.public_subnet_cidrs
    private_subnet_cidrs = var.private_subnet_cidrs
    database_subnet_cidrs = var.database_subnet_cidrs
    is_peering_required = true
    
}


















