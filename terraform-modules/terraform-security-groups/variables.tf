variable "project_name" {
  type    = string
  default = "openservice"
}

variable "OS_Public_IPaddrs" {
  default = {
    openvpn_ipaddr = "51.82.32.32/32"
    os_ipaddr      = "2.201.41.86/32"
    zabbix_ipaddr  = "51.82.32.128/32"
  }
}

variable "environment" {
  type = string
}