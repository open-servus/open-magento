resource "aws_acm_certificate" "cert" {
  domain_name               = var.project_dns_name
  subject_alternative_names = ["*.${var.project_dns_name}"]

  validation_method = "DNS"

  tags = {
    Environment = "${var.project_name}-${var.environment}"
  }

  lifecycle {
    create_before_destroy = true
  }
}