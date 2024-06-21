# Issue a cert for each fully qualified domain name
resource "aws_acm_certificate" "cert" {
  domain_name               = local.cert_domain
  key_algorithm             = var.key_algorithm
  subject_alternative_names = local.sans
  validation_method         = "DNS"

  dynamic "validation_option" {
    for_each = local.validation_options
    content {
      domain_name       = validation_option.value.domain_name
      validation_domain = validation_option.value.validation_domain
    }
  }

  tags = var.tags

  lifecycle {
    create_before_destroy = true
  }
}

# For each domain validation option, create a the validation record. Because we
# can have SANs, we may have more than 1.
resource "aws_route53_record" "validation" {
  for_each = {
    for dvo in aws_acm_certificate.cert.domain_validation_options :
    dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }
  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = local.validation_zones[each.key]
}

resource "aws_acm_certificate_validation" "cert" {
  certificate_arn = aws_acm_certificate.cert.arn
  validation_record_fqdns = [
    for record in aws_route53_record.validation : record.fqdn
  ]
}
