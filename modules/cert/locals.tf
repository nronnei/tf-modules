data "aws_route53_zone" "validation_domain" {
  for_each = toset(var.domains)
  name     = each.value
}

locals {
  cert_domain = join(".", compact([var.subdomains[0], var.domains[0]]))
  # Set up validation options for all possible subdomain/domain combinations.
  validation_options = [
    for parts in setproduct(var.subdomains, var.domains) :
    { domain_name = join(".", parts), validation_domain = parts[1] }
  ]
  # Create a SAN for anything that's _not_ the primary cert domain.
  sans = [
    for vo in local.validation_options : vo.domain_name
    if vo.domain_name != local.cert_domain
  ]
  # Map each FQDN to its hosted zone ID so we can easily create validation
  # records in Route53
  validation_zones = {
    for opt in local.validation_options :
    opt.domain_name => data.aws_route53_zone.validation_domain[opt.validation_domain].zone_id
  }
}
