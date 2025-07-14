data "aws_iam_policy_document" "lambda_assume_role" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "lambda_policy" {
  statement {
    actions = [
      "ec2:StartInstances",
      "ec2:StopInstances",
      "ec2:DescribeInstances"
    ]
    resources = ["*"]
  }
  statement {
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]
    resources = ["arn:aws:logs:*:*:*"]
  }
}

data "aws_ssm_parameter" "backend_sg_id" {
     name ="/${var.project_name}/${var.environment}/backend_sg_id"
     
 }

data "aws_ssm_parameter" "app_alb_listener_arn" {
  name  = "/${var.project_name}/${var.environment}/app_alb_listener_arn"
  
}

data "aws_ssm_parameter" "private_subnet_ids" {

     name = "/${var.project_name}/${var.environment}/private_subnet_ids"
     
     }

     
data  "aws_ssm_parameter" "vpc_id" {
    name = "/${var.project_name}/${var.environment}/vpc_id"
}

data "aws_ami" "devops" {

    most_recent = true
    owners = [222352935292] # aws account id
    filter {
      
      name = "name"
      values = ["test5555"]
    }
    filter {
      name = "root-device-type"
      values = ["ebs"]
    }

    filter {
      name = "virtualization-type"
      values = ["hvm"]
    }
}
