cat <<EOF >tf-env-config/backend.tf
terraform {
  backend "s3" {
    access_key = "$(echo $AWS_ACCESS_KEY_ID)"
    secret_key = "$(echo $AWS_SECRET_ACCESS_KEY)"
    bucket     = "open-services-project-cloud-tf-state"
    key        = "openservice/terraform.tfstate"
    region     = "us-east-1"
    encrypt    = true
  }
}
EOF