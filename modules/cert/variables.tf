variable "domains" {
  description = "All the domains to include on the cert. The first one in the list is the 'primary' domain."
  type        = list(string)
  nullable    = false

  validation {
    error_message = "At least one domain must be specified."
    condition     = length(var.domains) > 0
  }
}

variable "subdomains" {
  description = "Subdomains to combine w/ each domain, creating FQDNs for the cert. The first one in the list is the 'primary' subdomain. Optional"
  type        = list(string)
  nullable    = false
  default     = [""]
}

variable "key_algorithm" {
  description = "Algorithm to use for the cert."
  type        = string
  default     = "RSA_2048"
}

variable "tags" {
  description = "Tags to apply to all created resources."
  type        = map(string)
  default     = {}
}
