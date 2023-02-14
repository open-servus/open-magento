#===========================================================================================
#SG_admin
#===========================================================================================

# Our default security group to access
# the instances over SSH and HTTP
data "http" "ip" {
  url = "https://ifconfig.me"
}

resource "aws_security_group" "admin" {
  name        = var.project_name
  description = "Used in OS"

  tags = {
    Name        = "${var.project_name}"
    Environment = var.environment
  }
}

resource "aws_security_group_rule" "admin_to_0" {
  type             = "egress"
  from_port        = 0
  to_port          = 0
  protocol         = "-1"
  cidr_blocks      = ["0.0.0.0/0"]
  ipv6_cidr_blocks = ["::/0"]

  security_group_id = aws_security_group.admin.id
}

resource "aws_security_group_rule" "admin_22" {
  type        = "ingress"
  from_port   = 22
  to_port     = 22
  protocol    = "tcp"
  cidr_blocks = [var.OS_Public_IPaddrs.os_ipaddr, var.OS_Public_IPaddrs.openvpn_ipaddr, "${data.http.ip.response_body}/32"]

  security_group_id = aws_security_group.admin.id
}

resource "aws_security_group_rule" "admin_443" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = [var.OS_Public_IPaddrs.os_ipaddr, var.OS_Public_IPaddrs.openvpn_ipaddr, "${data.http.ip.response_body}/32"]
  security_group_id = aws_security_group.admin.id
}

#Zabbix
resource "aws_security_group_rule" "admin_zabbix" {
  type        = "ingress"
  from_port   = 10050
  to_port     = 10050
  protocol    = "tcp"
  cidr_blocks = [var.OS_Public_IPaddrs.os_ipaddr]

  security_group_id = aws_security_group.admin.id
}

resource "aws_security_group_rule" "admin_1" {
  type      = "ingress"
  from_port = 3306
  to_port   = 3306
  protocol  = "tcp"
  self      = true

  security_group_id = aws_security_group.admin.id
}

resource "aws_security_group_rule" "admin_2" {
  type      = "ingress"
  from_port = 6379
  to_port   = 6379
  protocol  = "tcp"
  self      = true

  security_group_id = aws_security_group.admin.id
}

resource "aws_security_group_rule" "admin_es" {
  type      = "ingress"
  from_port = 9200
  to_port   = 9200
  protocol  = "tcp"
  self      = true

  security_group_id = aws_security_group.admin.id
}

resource "aws_security_group_rule" "admin_3" {
  type      = "ingress"
  from_port = 22
  to_port   = 22
  protocol  = "tcp"
  self      = true

  security_group_id = aws_security_group.admin.id
}

