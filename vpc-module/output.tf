 output "aws_vpc_info" {
   value= module.vpc.vpc_id
 }

 output "az_info" {
  value =  module.vpc.az_zones.az_info
 }

 output "default_vpc_info" {
   value = module.vpc.default_vpc_info
 }

 output "main_route_table_info" {
   value = module.vpc.main_route_table.info
 }