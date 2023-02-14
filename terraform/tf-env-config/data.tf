data "ansiblevault_path" "aws_access_key" {
  path = "./secrets/aws_private_info.enc.yml"
  key  = "access_key"
}

data "ansiblevault_path" "aws_secret_key" {
  path = "./secrets/aws_private_info.enc.yml"
  key  = "secret_key"
}

data "ansiblevault_path" "ansible_vault_password" {
  path = "./secrets/ansible.enc.yml"
  key  = "ansible_vault_password"
}

data "ansiblevault_path" "ansible_vault_ssh_public_key" {
  path = "./secrets/ssh_public_key.enc.yml"
  key  = "ansible_vault_public_key"
}

data "ansiblevault_path" "ansible_vault_infra_master_pass" {
  path = "./secrets/infra.enc.yml"
  key  = "aws_rds_master_pass"
}

# Declare the data source
data "aws_availability_zones" "available" {
  state = "available"
}