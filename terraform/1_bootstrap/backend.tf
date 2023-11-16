terraform {
  backend "s3" {
    bucket  = "umtao-project-cloud-tf-state"
    key     = "openservice/terraform.tfstate"
    region  = "us-east-1"
    encrypt = true
  }
}
