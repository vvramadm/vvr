module "alb" {
  source = "terraform-aws-modules/alb/aws"
  internal = true
  # expense-dev-app-alb
  name    = "${var.project_name}-${var.environment}-app-alb"
  vpc_id  = data.aws_ssm_parameter.vpc_id.value
  ip_address_type     = "ipv4"
  load_balancer_type = "application"
  subnets = local.private_subnet_ids
  create_security_group= false
  security_groups = [local.app_alb_sg_id]
  enable_deletion_protection = false
  tags = merge(
    var.common_tags,
    {
        Name = "${var.project_name}-${var.environment}-app-alb"
    }
  )
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = module.alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/html"
      message_body = "<h1>Hello, I am from backend APP ALB</h1>"
      status_code  = "200"
    }
  }
}



module "records" {
  source  = "terraform-aws-modules/route53/aws//modules/records"
  
  zone_name = var.zone_name

  records = [
    {
  
      name    = "*.app-dev"
      type    = "A"
      alias = {
      name                   = module.alb.dns_name
      zone_id                = module.alb.zone_id
          }
      allow_overwrite= true
    }
  ]
  }