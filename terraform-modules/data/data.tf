# Declare the data source
data "aws_availability_zones" "available" {
  state = "available"
}

## definition of the base image we start from
data "aws_ami" "debian_base_image" {
  filter {
    name   = "name"
    values = ["debian-12-${var.arch}-*"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  most_recent = true
  owners      = ["136693071363"]
}