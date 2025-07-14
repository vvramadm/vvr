
module "vvr-backend" {
 
  source  = "terraform-aws-modules/ec2-instance/aws"
  #count = 6
  for_each = var.instances
  ami                    = data.aws_ami.devops.id # golden AMI
  name = each.key #vvr-dev-backend
  create_security_group = false
  vpc_security_group_ids = [local.backend_sg_id]
  instance_type          = each.value
  subnet_id   = local.private_subnet_id
  tags = merge(
    var.common_tags,
    {
        Name = "${var.project_name}-${var.environment}-backend"
    }
  )
}

# resource "aws_lb_target_group" "vvr-backend" {
#   name     = "${local.resource_name}-backend-tg"
#   port     = 8080
#   protocol = "HTTP"
#   vpc_id   = local.vpc_id
#   deregistration_delay = 60

#   health_check {
#     healthy_threshold = 2
#     unhealthy_threshold = 2
#     timeout = 5
#     protocol = "HTTP"
#     port = 8080
#     path = "/health"
#     matcher = "200-299"
#     interval = 10
#   }
# }
# resource "aws_lb_target_group_attachment" "backend" {
#   target_group_arn = aws_lb_target_group.vvr-backend.arn
#   target_id        = module.vvr-backend.id
#   port             = 80
# }

# resource "aws_iam_role" "lambda_exec" {
#   name = "lambda_exec_role"
#   assume_role_policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [{
#       Action = "sts:AssumeRole"
#       Effect = "Allow"
#       Principal = {
#         Service = "lambda.amazonaws.com"
#       }
#     }]
#   })
# }

# resource "aws_iam_policy_attachment" "lambda_basic" {
#   name       = "lambda-basic-policy"
#   roles      = [aws_iam_role.lambda_exec.name]
#   policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
# }

# resource "aws_lambda_function" "ec2_scaler" {
#   filename         = "${path.module}/lambda/scale.zip"
#   function_name    = "ec2_scaler"
#   role             = aws_iam_role.lambda_exec.arn
#   handler          = "scale.lambda_handler"
#   runtime          = "python3.9"
#   source_code_hash = filebase64sha256("${path.module}/lambda/scale.zip")
#   timeout          = 30

#   environment {
#     variables = {
#       INSTANCE_IDS = module.backend-vvr.id
#       TARGET_GROUP_ARN = aws_lb_target_group.vvr-backend
#     }
#   }
# }

# resource "aws_cloudwatch_event_rule" "scale_out" {
#   name        = "scale_out"
#   description = "Scale out at 9AM"
#   schedule_expression = "cron(0 9 * * ? *)"
# }

# resource "aws_cloudwatch_event_rule" "scale_in" {
#   name        = "scale_in"
#   description = "Scale in at 6PM"
#   schedule_expression = "cron(0 18 * * ? *)"
# }

# resource "aws_cloudwatch_event_target" "scale_out_target" {
#   rule = aws_cloudwatch_event_rule.scale_out.name
#   arn  = aws_lambda_function.ec2_scaler.arn

#   input = jsonencode({
#     action = "scale_out"
#   })
# }

# resource "aws_cloudwatch_event_target" "scale_in_target" {
#   rule = aws_cloudwatch_event_rule.scale_in.name
#   arn  = aws_lambda_function.ec2_scaler.arn

#   input = jsonencode({
#     action = "scale_in"
#   })
# }

# resource "aws_lambda_permission" "allow_eventbridge" {
#   statement_id  = "AllowExecutionFromEventBridge"
#   action        = "lambda:InvokeFunction"
#   function_name = aws_lambda_function.ec2_scaler.function_name
#   principal     = "events.amazonaws.com"
#   source_arn    = aws_cloudwatch_event_rule.scale_out.arn
# }

# resource "aws_cloudwatch_metric_alarm" "cpu_high" {
#   alarm_name          = "HighCPUUtilization"
#   comparison_operator = "GreaterThanThreshold"
#   evaluation_periods  = "2"
#   metric_name         = "CPUUtilization"
#   namespace           = "AWS/EC2"
#   period              = "300"
#   statistic           = "Average"
#   threshold           = "80"
#   alarm_description   = "This metric monitors high CPU usage"
#   dimensions = {
#     InstanceId = module.vvr-backend.ec2_instance_ids[0] # Monitor one of the base instances
#   }
# }
