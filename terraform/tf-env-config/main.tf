provider "ansiblevault" {
  root_folder = path.module
}

locals {
  environment     = "prod"
  region          = "us-east-1"
  tf_state_bucket = "open-services-project-cloud-tf-state"
}

resource "random_integer" "priority" {
  min = 0
  max = 1
}