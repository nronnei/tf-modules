# ACM Certificate (Public)

This module creates a Public SSL Certificate with ACM using DNS validation.

Pre-requisites:

- DNS for your domains is managed in Route53.
- Hosted zones exist for the domains you want to include in the cert.

Gotchas:

- Wildcard certs have not been tested and might not work.

## Key Variables

| Name        | Description                                                                                  | Required                         |
| ----------- | -------------------------------------------------------------------------------------------- | -------------------------------- |
| `domains`   | The domains to include in the cert, the first of which is considered the "primary".          | Yes.                             |
| `subdomain` | Subdomains to combine with each domain to create FQDNs. The first is considered the primary. | No (you can create a bare cert). |

We look up the public hosted zone for each entry in `domains`. The first one in the list gets combined with the first subdomain to create the FQDN for the cert. All other combinations get added as Subject Alternative Names (SANs).

## Dependencies on other infra

This module requires the hosted zones to already exist in Route53 to work properly.
