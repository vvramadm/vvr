resource "aws_security_group" "main" {

    vpc_id = data.aws_ssm_parameter.vpc_id.value
    name = local.sg_final_name
    tags = merge(

        var.common_tags,

        {
            Name= local.sg_final_name
        }

    )

    egress  {

        from_port = 0
        to_port   = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
  
}