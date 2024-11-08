locals {
  environment     = "prod"
  region          = "eu-central-1"
}

resource "random_integer" "priority" {
  min = 0
  max = 1
}

# Declare the data source
data "aws_availability_zones" "available" {
  state = "available"
}