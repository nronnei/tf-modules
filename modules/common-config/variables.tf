variable "namespace" {
  type        = string
  default     = "snappt"
  description = "short (2-4 characters) that prefixes all names"
}

# Having the default set to % in the next three variables allows them to be optional in the names.
# When they are processed in the locals section of main.tf the invalid character will be removed leaving
# an empty string.

variable "env" {
  type        = string
  default     = "%"
  description = "Used to group resources in to resource groups"
}

variable "friendlyname" {
  type        = string
  default     = "%"
  description = "An arbitrary name for what your building"
}

variable "subtype" {
  type        = string
  default     = ""
  description = "subcomponent that is related to another resource. (i.e. nic, pip, disk, etc.)"
}

variable "layer" {
  type        = string
  default     = "--"
  description = "Application tier. Related to costs. (one of: infrastructure, application, data, network, observability)"

  validation {
    error_message = "Supplied value doesn't match our schema. See the common-config module docs."
    condition = contains([
      "infrastructure",
      "application",
      "data",
      "network",
      "observability",
      "--"
    ], var.layer)
  }
}

variable "product_domain" {
  type        = string
  default     = "--"
  description = "Name of the product feature or application sub-component. (i.e. report-generation)"
}

variable "technical_domain" {
  type        = string
  default     = "--"
  description = "Name of the technical domain this group of resources belongs to (e.g. results-delivery)"
}

variable "additional_tags" {
  type        = map(string)
  default     = {}
  description = "Additional tags to be merged with the standard tags"
}

variable "owner" {
  description = "Name of the team that owns the resource."
  type        = string
  default     = "--"
}

variable "git_repo" {
  description = "Name of the git repository (including the organization) that controls the infra."
  type        = string
  default     = "--"
}

variable "invalid_characters" {
  type        = string
  default     = "/[^a-zA-Z0-9-]/"
  description = "Regex to replace chars with empty string in `namespace`, `environment`, `stage` and `name`. By default only hyphens, letters and digits are allowed, all other chars are removed"
}

variable "name_count" {
  default     = 1
  description = "How many you want created for name_list and tag_list"
  type        = number
}
