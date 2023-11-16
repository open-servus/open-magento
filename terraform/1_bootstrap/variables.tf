variable "region" {
  type    = string
  default = "eu-central-1"
}

variable "aws_rds_master_pass" {
  type = string
}

variable "ssh_public_key" {
  type = string
}