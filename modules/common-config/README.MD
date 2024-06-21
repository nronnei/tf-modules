# `common-config`

This module is very simple. It doesn't create any actual resources, it only gives outputs. These outputs can then be used across our modules to supply commonly used values. It also constructs names that fall in line with our standard naming conventions.

## Basic usage

To get the values from this module, include the following statement making sure the relative path is correct.

```hcl
module "cc" {
  source            = "registry.my.domain/modules/null/common-config"
  version           = "1.0.0"

  env               = "dev"
  friendlyname      = "auth"
  subtype           = "vpc"
  layer             = "network"
  product_domain    = "my-product"
  technical_domain  = "report-generation"
  owner             = "my-team"
  git_repo          = "git-org/this-repository"
}
```

Then you can reference the values with:
module.cc.[output]

```hcl
tags = module.cc.tags
```

## Inputs

The following inputs are used to create a standardized name.

## Output examples include:

### common_tags

A common set of static tags that we want to give all of our terraform managed resources. These values can then be merged with other values to make a complete map of tags.

Example:

```hcl
tags = merge(local.tags, module.cc.common_tags)
```

## The following are common lookup tables that this module returns as a map. You can then use the lookup function to get standard values.

### region_abbrev

This is a map from which you can lookup a short version of the region names.

Example:

```hcl
lookup(module.cc.region_abbrev, "us-east-1") # returns use1
```
