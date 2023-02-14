variable "environment" {}

variable "project_name" {}

variable "sg_admin" {}

variable "sg_whitelist" {}

variable "availability_zone" {}

variable "aws_rds_master_pass" {
  sensitive = true
}

variable "project_db_specs" {}