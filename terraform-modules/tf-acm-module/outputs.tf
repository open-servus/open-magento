output "acm_arn" {
  value = aws_acm_certificate.cert.arn
}
# output "DOMAIN_VALIDATION_OPTIONS" {
#   value = aws_acm_certificate.cert.domain_validation_options
# }