resource "aws_security_group_rule" "admin_allow_443_for_lb" {
  type                     = "ingress"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.alb_sg.id

  security_group_id = aws_security_group.admin.id
}

resource "aws_security_group_rule" "admin_allow_nfs_1_tcp" {
  type      = "ingress"
  from_port = 111
  to_port   = 111
  protocol  = "tcp"
  self      = true

  security_group_id = aws_security_group.admin.id
}

resource "aws_security_group_rule" "admin_allow_nfs_1_udp" {
  type      = "ingress"
  from_port = 111
  to_port   = 111
  protocol  = "udp"
  self      = true

  security_group_id = aws_security_group.admin.id
}

resource "aws_security_group_rule" "admin_allow_nfs_2_tcp" {
  type      = "ingress"
  from_port = 2049
  to_port   = 2049
  protocol  = "tcp"
  self      = true

  security_group_id = aws_security_group.admin.id
}

resource "aws_security_group_rule" "admin_allow_nfs_2_udp" {
  type      = "ingress"
  from_port = 2049
  to_port   = 2049
  protocol  = "udp"
  self      = true

  security_group_id = aws_security_group.admin.id
}

resource "aws_security_group_rule" "admin_allow_mq" {
  type      = "ingress"
  from_port = 5671
  to_port   = 5671
  protocol  = "tcp"
  self      = true

  security_group_id = aws_security_group.admin.id
}