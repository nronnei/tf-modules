locals {
  region_abbrev = {
    us-east-1 = "use1"
    us-east-2 = "use2"
    us-west-1 = "usw1"
    us-west-2 = "usw2"
  }

  ### This section formats the values appropriately and constructs the name tag.
  namespace             = lower(replace(var.namespace, var.invalid_characters, ""))
  env                   = lower(replace(var.env, var.invalid_characters, ""))
  layer                 = lower(replace(var.layer, var.invalid_characters, ""))
  product_domain        = lower(replace(var.product_domain, var.invalid_characters, ""))
  technical_domain      = lower(replace(var.technical_domain, var.invalid_characters, ""))
  friendlyname          = lower(replace(var.friendlyname, var.invalid_characters, ""))
  subtype               = lower(replace(var.subtype, var.invalid_characters, ""))
  owner                 = lower(replace(var.owner, var.invalid_characters, ""))
  constructed_name      = join("-", compact([local.namespace, local.env, local.friendlyname, local.subtype]))
  constructed_name_path = "/${join("/", compact([local.namespace, local.env, local.friendlyname, local.subtype]))}"
  managedby             = "terraform"

  # This is the set of tags without the name tag. The name tag is seperated out
  # so that you can inject a numbered name later.
  common_tags = {
    env             = local.env
    Layer           = local.layer
    ProductDomain   = local.product_domain
    TechnicalDomain = local.technical_domain
    ManagedBy       = local.managedby
    Owner           = local.owner
    GitRepo         = var.git_repo
  }

  name_tag = {
    Name = local.constructed_name
  }

  standard_tags = merge(local.common_tags, var.additional_tags)
  standard_tag_list = [
    for k, v in local.standard_tags : "${k}:${v}"
  ]
}

# tflint-ignore: terraform_required_providers
resource "null_resource" "names" {
  count = var.name_count
  triggers = {
    name = join("", [local.constructed_name, format("%02d", count.index + 1)])
  }
}
