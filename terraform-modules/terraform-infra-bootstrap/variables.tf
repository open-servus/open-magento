variable "region" {
  type = string
}

variable "ssh_public_key" {
  sensitive = true
}

variable "aws_amis" {
  default = {
    general = ""
    web     = ""
  }
}

variable "central_aws_region" {
  description = "AWS default region of AMI"
  default     = "us-east-1" ##Default AMI openservice
}

variable "project_name" {
  type    = string
  default = "openservice"
}