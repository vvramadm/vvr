output "alb_dns_name" {
  description = "The DNS name of the Application Load Balancer"
  value       = module.alb.dns_name
}

# output "subnets" {
  
#   value = local.private_subnet_ids
# }