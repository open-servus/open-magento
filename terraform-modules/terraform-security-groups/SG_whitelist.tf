#===========================================================================================
#SG_whitelist
#===========================================================================================

# Our default security group to access
# the instances over SSH and HTTP
resource "aws_security_group" "whitelist" {
  name        = "${var.project_name}-whitelist"
  description = "Used in OS"

  tags = {
    Name        = "${var.project_name}-whitelist"
    Environment = var.environment
  }
}

# outbound internet access
resource "aws_security_group_rule" "whitelist_ssh" {
  type        = "ingress"
  from_port   = 22
  to_port     = 22
  protocol    = "tcp"
  cidr_blocks = [var.OS_Public_IPaddrs.openvpn_ipaddr]

  security_group_id = aws_security_group.whitelist.id
}
