variable "region" {
  type = string
}

variable "ssh_public_key" {
  sensitive = true
}

variable "aws_amis" {
  default = {
    general = "ami-0d53a3ba77632d713"
    web     = "ami-0d53a3ba77632d713"
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