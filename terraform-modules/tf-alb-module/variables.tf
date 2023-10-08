variable "environment" {}

variable "project_name" {}

variable alb_sg {}

variable web_instance_id {}

variable acm_arn {}

variable subnets {}

variable vpc_id {}

variable "aws_lb_parameters" {
  default = {
    project_ssl_policy      = "ELBSecurityPolicy-FS-1-2-2019-08"
  }
}