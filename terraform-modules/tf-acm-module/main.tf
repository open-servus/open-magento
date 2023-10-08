resource "aws_acm_certificate" "cert" {
  #domain_name               = var.project_dns_name
  #subject_alternative_names = ["*.${var.project_dns_name}"]

  private_key = "${file("${path.module}/self-ca-key.j2")}"
  certificate_body = "${file("${path.module}/self-ca-cert.j2")}"
  #validation_method = "DNS"

  tags = {
    Environment = "${var.project_name}-${var.environment}"
  }

  lifecycle {
    create_before_destroy = true
  }
}