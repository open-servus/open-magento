output "defaults" {
  value = {
    project_name           = "openservice"
    project_domain         = "openservice.cloud"
    project_domain_pma     = "pma.openservice.cloud"
    user_project_firstname = "Open"
    user_project_lastname  = "Service"
    user_project_email     = "online@openservice.cloud"
  }
}

#Latest Debian ARM64 AMI from here: https://wiki.debian.org/Cloud/AmazonEC2Image/Bullseye
output "aws_amis" {
  value = {
    general = data.aws_ami.debian_base_image.id
    web     = data.aws_ami.debian_base_image.id
    nfs     = data.aws_ami.debian_base_image.id
  }
}


output "aws_availability_zone" {
  value = data.aws_availability_zones.available.names[random_integer.priority.result]
}

output "aws_instance_type" {
  value = {
    general  = "m6g.large"
    admin    = "m6g.large"
    master   = "t4g.micro"
    nfs      = "t4g.micro" #"t3.small"
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