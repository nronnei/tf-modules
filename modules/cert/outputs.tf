output "arn" {
  value = aws_acm_certificate.cert.arn
}

output "domain_name" {
  value = aws_acm_certificate.cert.domain_name
}

output "protected_domains" {
  value = local.validation_options[*].domain_name
}

output "domains_zone_ids" {
  description = "A map keyed by domain main with a value of the hosted zone ID it was validated in."
  value = {
    for dn in local.validation_options[*].domain_name :
    dn => local.validation_zones[dn]
  }
}

output "validation_options" {
  value = aws_acm_certificate.cert.validation_option
}

# Escape hatch if needed.
output "cert" {
  value = aws_acm_certificate.cert
}

# Escape hatch if needed.
output "validation" {
  value = aws_acm_certificate_validation.cert
}
