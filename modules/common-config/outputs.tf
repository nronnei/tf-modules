### common lookup tables
output "region_abbrev" {
  value = local.region_abbrev
}

### Normalized Values
# These values are the normalized version used for constructing tags.
output "namespace" {
  value = local.namespace
}
output "env" {
  value = local.env
}
output "friendlyname" {
  value = local.friendlyname
}
output "subtype" {
  value = local.subtype
}
output "name" {
  value = local.constructed_name
}

output "name_path" {
  description = "Same as name, but with the components joined by slashes instead of the delimeter."
  value       = local.constructed_name_path
}

### tag maps
output "tags" {
  description = "complete map of tags including name and additional_tags"
  value       = merge(local.common_tags, local.name_tag, var.additional_tags)
}

output "standard_tags" {
  description = "map of tags that doesn't include name tag"
  value       = local.standard_tags
}

output "common_tags" {
  description = "only the tags included in the module without the name tag"
  value       = local.common_tags
}

output "name_tag" {
  description = "name tag alone"
  value       = local.name_tag
}

### Additional outputs
output "names_list" {
  description = "A list created from adding two digits to the customized name incrementally"
  value       = null_resource.names[*].triggers.name
}

output "tag_list" {
  description = "The standard tags but in list format instead map."
  value       = local.standard_tag_list
}
