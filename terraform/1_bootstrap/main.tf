provider "aws" {
  region = module.data.defaults.region

  access_key = module.data.aws_access_key
  secret_key = module.data.aws_secret_key

}

data "aws_vpc" "default" {
  default = true
}

data "aws_subnet_ids" "subnets_ids" {
  vpc_id = data.aws_vpc.default.id
}

module "bootstrap" {
  source             = "../../terraform-modules/terraform-infra-bootstrap"
  ssh_public_key     = sensitive(module.data.ssh_public_key)
  aws_amis           = module.data.aws_amis
  project_name       = module.data.defaults.project_name
  region             = module.data.defaults.region
  central_aws_region = module.data.central_aws_region
}

module "sg" {
  source       = "../../terraform-modules/terraform-security-groups"
  project_name = module.data.defaults.project_name
  environment  = module.data.defaults.environment
}

module "admin" {
  source                = "git::https://github.com/open-servus/tf-ec2-module.git?ref=main"
  project_name          = module.data.defaults.project_name
  environment           = module.data.defaults.environment
  aws_key_pair          = module.bootstrap.aws_key_pair
  sg_instance_group_ids = [module.sg.sg_admin, module.sg.sg_whitelist]
  aws_ami               = module.data.defaults.region != module.data.central_aws_region ? module.bootstrap.os_ami : module.data.aws_amis.general
  availability_zone     = module.data.aws_availability_zone
  aws_instance_type     = module.data.aws_instance_type.admin
  eip_enabled           = true

}

module "rds" {
  source              = "../../terraform-modules/terraform-rds"
  environment         = module.data.defaults.environment
  project_name        = module.data.defaults.project_name
  aws_rds_master_pass = sensitive(module.data.aws_rds_master_pass)
  project_db_specs    = module.data.project_db_specs
  sg_admin            = module.sg.sg_admin
  sg_whitelist        = module.sg.sg_whitelist
  availability_zone   = module.data.aws_availability_zone

  count = module.data.install_plan == "small" ? 0 : 1
}

module "elasticsearch" {
  source                = "git::https://github.com/open-servus/tf-ec2-module.git?ref=main"
  project_name          = "${module.data.defaults.project_name}-es"
  environment           = module.data.defaults.environment
  aws_key_pair          = module.bootstrap.aws_key_pair
  sg_instance_group_ids = [module.sg.sg_admin, module.sg.sg_whitelist]
  aws_ami               = module.data.defaults.region != module.data.central_aws_region ? module.bootstrap.os_ami : module.data.aws_amis.general
  availability_zone     = module.data.aws_availability_zone
  aws_instance_type     = module.data.aws_instance_type.general

  count = module.data.install_plan == "small" ? 0 : 1
}

module "nfs" {
  source                = "git::https://github.com/open-servus/tf-ec2-module.git?ref=main"
  project_name          = "${module.data.defaults.project_name}-nfs"
  environment           = module.data.defaults.environment
  aws_key_pair          = module.bootstrap.aws_key_pair
  sg_instance_group_ids = [module.sg.sg_admin]
  aws_ami               = module.data.aws_amis.nfs
  availability_zone     = module.data.aws_availability_zone
  aws_instance_type     = module.data.aws_instance_type.nfs

  count = module.data.install_plan == "small" ? 0 : 1
}

module "elasticache" {
  source              = "git::https://github.com/open-servus/tf-elasticache-module.git?ref=main"
  environment         = module.data.defaults.environment
  project_name        = module.data.defaults.project_name
  project_redis_specs = module.data.project_redis_specs
  sg_elasticache      = module.sg.sg_admin
  availability_zone   = module.data.aws_availability_zone

  count = module.data.install_plan == "small" ? 0 : 1
}

module "acm" {
  source           = "../../terraform-modules/tf-acm-module"
  environment      = module.data.defaults.environment
  project_name     = module.data.defaults.project_name
  project_dns_name = "4-streams.com"

  count = module.data.install_plan == "small" ? 0 : 1
}

module "alb" {
  source       = "git::https://github.com/open-servus/tf-alb-module.git?ref=main"
  environment  = module.data.defaults.environment
  project_name = module.data.defaults.project_name
  alb_sg       = [module.sg.sg_alb]

  vpc_id          = data.aws_vpc.default.id
  subnets         = toset(data.aws_subnet_ids.subnets_ids.ids)
  web_instance_id = module.admin.instance_id
  acm_arn         = module.acm[0].acm_arn

  count = module.data.install_plan == "small" ? 0 : 1
}

module "waf" {
  source            = "git::https://github.com/open-servus/tf-waf-module.git?ref=main"
  environment       = module.data.defaults.environment
  project_name      = module.data.defaults.project_name
  whitelist_ipv4    = ["1.2.3.4/32", "5.6.7.8/32"]
  whitelist_ipv6    = ["2001:db8:abcd:0012::0/80"]
  blocked_ipv4      = ["3.2.3.4/32", "4.6.7.8/32"]
  blocked_ipv6      = ["2001:db8:abcd:0012::0/64"]
  blocked_countries = ["TV", "TN"]
  alb_arn           = module.alb[0].alb_arn

  count = module.data.install_plan == "small" ? 0 : 1
}

module "asg" {
  source                   = "git::https://github.com/open-servus/tf-asg-module.git?ref=main"
  environment              = module.data.defaults.environment
  project_name             = module.data.defaults.project_name
  availability_zones       = [module.data.aws_availability_zone]
  web_instance_id          = module.admin.instance_id
  aws_instance_type        = module.data.aws_instance_type.general
  aws_security_group       = module.sg.sg_admin
  aws_alb_target_group     = tolist(toset(module.alb[*].web_tg_arn))[0]
  launch_configuration_pfx = "was-0.0.3"

  count = module.data.install_plan == "small" ? 0 : 1
}

module "aws_magento_setup" {
  source           = "../../terraform-modules/terraform-aws-setup"
  admin_private_ip = module.admin.private_ip
  admin_public_ip  = module.admin.public_ip

  project_db_endpoint    = module.data.install_plan == "small" ? "127.0.0.1" : module.rds[0].project_db_endpoint
  project_cache_endpoint = module.data.install_plan == "small" ? "127.0.0.1" : module.elasticache[0].project_cache_endpoint

  elasticsearch_private_ip = module.data.install_plan == "small" ? "127.0.0.1" : module.elasticsearch[0].private_ip
  elasticsearch_public_ip  = module.data.install_plan == "small" ? module.admin.public_ip : module.elasticsearch[0].public_ip

  nfs_private_ip = module.data.install_plan == "small" ? "127.0.0.1" : module.nfs[0].private_ip
  nfs_public_ip  = module.data.install_plan == "small" ? module.admin.public_ip : module.nfs[0].public_ip

  project_name           = module.data.defaults.project_name
  project_domain         = module.data.defaults.project_domain
  project_domain_pma     = module.data.defaults.project_domain_pma
  user_project_firstname = module.data.defaults.user_project_firstname
  user_project_lastname  = module.data.defaults.user_project_lastname
  user_project_email     = module.data.defaults.user_project_email
  project_plan           = module.data.install_plan
}