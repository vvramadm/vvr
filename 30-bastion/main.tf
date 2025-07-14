 module "ec2_bastion" {
   source  = "terraform-aws-modules/ec2-instance/aws"

   name = "${local.resource_name}-bastion"
   ami = data.aws_ami.devops.id
   instance_type          = var.instance_type
   key_name               = var.key_name
   #monitoring             = true
   create_security_group = false
   vpc_security_group_ids = [local.bastion_sg_id]
   subnet_id              = local.public_subnet_id

   tags = {
     Terraform   = "true"
     Environment = "dev"
   }
   
 }

# resource "aws_ec2_instance_state" "ec2_bastion" {
#   instance_id = module.ec2_bastion.id
#   #state       = "stopped"
#   state       = "running"
# }

# module "ec2_bastion" {
#   source  = "../terraform-aws-ec2"

#   name = "${local.resource_name}-bastion"
#   ami = data.aws_ami.devops.id
#   instance_type          = var.instance_type
#   key_name               = var.key_name
#   #monitoring             = true
#   vpc_security_group_ids = [local.bastion_sg_id]
#   subnet_id              = local.public_subnet_ids

#   tags = {
#     Terraform   = "true"
#     Environment = "dev"
#   }
# }

