#===========================================================================================
#===========================================================================================

#RDS Database Server
/*
resource "aws_db_subnet_group" "default" {
  name = "${var.project_name}"

  tags = {
    Name = "RDS DB Subnet Group"
  }
}
*/

#DB Parameter group

resource "aws_db_parameter_group" "default" {
  name   = var.project_name
  family = var.project_db_specs.rds_familytype

  description = "RDS parameter group from Open Services"

  parameter {
    apply_method = "pending-reboot"
    name         = "bulk_insert_buffer_size"
    value        = "67108864"
  }

  parameter {
    apply_method = "pending-reboot"
    name         = "innodb_flush_log_at_trx_commit"
    value        = "2"
  }

  parameter {
    apply_method = "pending-reboot"
    name         = "innodb_log_buffer_size"
    value        = "10485760"
  }

  parameter {
    apply_method = "pending-reboot"
    name         = "innodb_thread_concurrency"
    value        = "32"
  }

  parameter {
    apply_method = "pending-reboot"
    name         = "join_buffer_size"
    value        = "8388608"
  }

  parameter {
    apply_method = "pending-reboot"
    name         = "key_buffer_size"
    value        = "256000000"
  }

  parameter {
    apply_method = "pending-reboot"
    name         = "log_bin_trust_function_creators"
    value        = "1"
  }

  parameter {
    apply_method = "pending-reboot"
    name         = "max_allowed_packet"
    value        = "67108864"
  }

  parameter {
    apply_method = "pending-reboot"
    name         = "max_connect_errors"
    value        = "10000"
  }

  parameter {
    apply_method = "pending-reboot"
    name         = "max_heap_table_size"
    value        = "536870912"
  }

  parameter {
    apply_method = "pending-reboot"
    name         = "myisam_sort_buffer_size"
    value        = "134217728"
  }

  parameter {
    apply_method = "pending-reboot"
    name         = "query_cache_limit"
    value        = "134217728"
  }

  parameter {
    apply_method = "pending-reboot"
    name         = "query_cache_size"
    value        = "536870912"
  }

  parameter {
    apply_method = "pending-reboot"
    name         = "query_cache_type"
    value        = "1"
  }

  parameter {
    apply_method = "pending-reboot"
    name         = "read_buffer_size"
    value        = "2097152"
  }

  parameter {
    apply_method = "pending-reboot"
    name         = "read_rnd_buffer_size"
    value        = "16777216"
  }

  parameter {
    apply_method = "pending-reboot"
    name         = "sort_buffer_size"
    value        = "8388608"
  }

  parameter {
    apply_method = "pending-reboot"
    name         = "table_open_cache"
    value        = "8048"
  }

  parameter {
    apply_method = "pending-reboot"
    name         = "thread_cache_size"
    value        = "32"
  }

  parameter {
    apply_method = "pending-reboot"
    name         = "tmp_table_size"
    value        = "536870912"
  }

}

resource "aws_db_instance" "default" {
  allocated_storage   = var.project_db_specs.rds_allocated_storage
  storage_type        = "gp2"
  engine              = var.project_db_specs.rds_engine
  engine_version      = var.project_db_specs.rds_engine_version
  instance_class      = var.project_db_specs.rds_instance_class
  db_name             = var.project_name
  identifier          = var.project_name
  skip_final_snapshot = "true"
  username            = "master"
  password            = var.aws_rds_master_pass
  publicly_accessible = "true"
  #storage_encrypted    = "true"
  backup_retention_period = "14"
  copy_tags_to_snapshot   = "true"
  parameter_group_name    = aws_db_parameter_group.default.name
  #db_subnet_group_name = "${aws_db_subnet_group.default.name}"
  vpc_security_group_ids = ["${var.sg_admin}"]
  availability_zone      = var.availability_zone
  tags = {
    Environment = var.environment
  }
}
