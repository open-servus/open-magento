cat <<EOF >tf-env-config/backend.tf
terraform {
  backend "s3" {
    access_key = "$(ansible-vault view tf-env-config/secrets/aws_private_info.enc.yml | grep "^access_key:" | cut -d ':' -f 2 | tr -d ' ')"
    secret_key = "$(ansible-vault view tf-env-config/secrets/aws_private_info.enc.yml | grep "^secret_key:" | cut -d ':' -f 2 | tr -d ' ')"
    bucket     = "open-services-project-cloud-tf-state"
    key        = "openservice/terraform.tfstate"
    region     = "us-east-1"
    encrypt    = true
  }
}
EOF