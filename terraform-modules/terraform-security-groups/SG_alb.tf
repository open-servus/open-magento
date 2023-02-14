resource "aws_security_group" "alb_sg" {
  name        = "${var.project_name}-${var.environment}-lb"
  description = "Used in Project"

  tags = {
    Name        = "${var.project_name}-${var.environment}-lb"
    Environment = var.environment
  }
}

# HTTP HTTPS access from the VPC
resource "aws_security_group_rule" "alb_sg_80" {
  type             = "ingress"
  from_port        = 80
  to_port          = 80
  protocol         = "tcp"
  cidr_blocks      = ["0.0.0.0/0"]
  ipv6_cidr_blocks = ["::/0"]

  security_group_id = aws_security_group.alb_sg.id
}

resource "aws_security_group_rule" "alb_sg_443" {
  type             = "ingress"
  from_port        = 443
  to_port          = 443
  protocol         = "tcp"
  cidr_blocks      = ["0.0.0.0/0"]
  ipv6_cidr_blocks = ["::/0"]

  security_group_id = aws_security_group.alb_sg.id
}

# outbound internet access
resource "aws_security_group_rule" "alb_sg_to_0" {
  type             = "egress"
  from_port        = 0
  to_port          = 0
  protocol         = "-1"
  cidr_blocks      = ["0.0.0.0/0"]
  ipv6_cidr_blocks = ["::/0"]

  security_group_id = aws_security_group.alb_sg.id
}
