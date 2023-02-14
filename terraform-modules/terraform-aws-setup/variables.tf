variable "project_db_endpoint" {
  type    = string
  default = "127.0.0.1"
}

variable "project_cache_endpoint" {
  type    = string
  default = "127.0.0.1"
}

variable "admin_private_ip" {
  type = string
}

variable "admin_public_ip" {
  type = string
}

variable "elasticsearch_private_ip" {
  type = string
}

variable "elasticsearch_public_ip" {
  type = string
}

variable "nfs_private_ip" {
  type = string
}

variable "nfs_public_ip" {
  type = string
}

variable "project_name" {
  type    = string
  default = "umdummy"
}


variable "user_project_firstname" {
  type    = string
  default = "Open"
}

variable "user_project_lastname" {
  type    = string
  default = "Service"
}

variable "user_project_email" {
  type    = string
  default = "dummy@openservice.cloud"
}


variable "project_domain" {
  type    = string
  default = "dummy.cloud"
}

variable "project_domain_pma" {
  type    = string
  default = "pma.dummy.cloud"
}

variable "project_plan" {
  type = string
}