output "defaults" {
  value = {
    namespace              = local.environment
    environment            = local.environment
    region                 = local.region
    project_name           = "orangemag"
    project_domain         = "orangemag.cloud"
    project_domain_pma     = "pma.orangemag.cloud"
    user_project_firstname = "Orangemag"
    user_project_lastname  = "Service"
    user_project_email     = "online@orangemag.cloud"
  }
}

output "aws_access_key" {
  value     = data.ansiblevault_path.aws_access_key.value
  sensitive = true
}

output "aws_secret_key" {
  value     = data.ansiblevault_path.aws_secret_key.value
  sensitive = true
}

output "aws_rds_master_pass" {
  value     = data.ansiblevault_path.ansible_vault_infra_master_pass.value
  sensitive = true
}

output "ssh_public_key" {
  value     = data.ansiblevault_path.ansible_vault_ssh_public_key.value
  sensitive = true
}

#Latest Debian ARM64 AMI from here: https://wiki.debian.org/Cloud/AmazonEC2Image/Bullseye
output "aws_amis" {
  value = {
    general = "ami-0d53a3ba77632d713"
    web     = "ami-0d53a3ba77632d713"
    #nfs     = "ami-0fec2c2e2017f4e7b"
    nfs     = "ami-0d53a3ba77632d713" #"ami-048569764020d86d8"
  }
}

output "central_aws_region" {
  value = "us-east-1" ##Default AMI openservice
}

output "aws_availability_zone" {
  value = data.aws_availability_zones.available.names[random_integer.priority.result]
}

output "install_plan" {
  value = "large"
  #Can be small, medium or large
}

output "aws_instance_type" {
  value = {
    general  = "m6g.large"
    admin    = "m6g.large"
    master   = "t4g.micro"
    nfs      = "t4g.small"
    varnish  = "t4g.micro"
    cloudlog = "t4g.micro"
  }
}

output "project_db_specs" {
  value = {
    engine                = "aurora-mysql"
    familytype            = "aurora-mysql5.7"
    engine_version        = "5.7.mysql_aurora.2.09.2"
    instance_class        = "db.m6g.large"
    rds_engine            = "mysql"
    rds_familytype        = "mysql5.7"
    rds_engine_version    = "5.7"
    rds_instance_class    = "db.m5.large"
    rds_allocated_storage = "10"
  }

}

output "project_redis_specs" {
  value = {
    family            = "redis6.x"
    engine_version    = "6.x"
    cache_node_type   = "cache.t3.medium"
    session_node_type = "cache.t4g.small"
  }
}