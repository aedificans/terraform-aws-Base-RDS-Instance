locals {
  _formatting = {
    env_display      = title(var.environment.name)
    env_resource     = var.environment.abbreviation
    network_display  = title(var.tagging.network)
    network_resource = replace(var.tagging.network, "/[_ ]/", "-")
    service_display  = title(var.naming.display)
    service_resource = coalesce(var.naming.resource, replace(var.naming.display, "/[ ]/", "-"))
  }
  naming = {
    display  = "${local._formatting.service_display} ${local._formatting.env_display} ${title(local._formatting.network_display)}"
    iam      = replace("${local._formatting.service_display}${local._formatting.env_display}${local._formatting.network_display}", "/[ _-]/", "")
    resource = lower("${local._formatting.service_resource}-${local._formatting.env_resource}-${local._formatting.network_resource}")
  }
  tags = merge(
    var.tagging.additional_tags,
    tomap({
      "${var.tagging.tag_key_prefix}:environment"     = var.environment.name
      "${var.tagging.tag_key_prefix}:network"         = var.tagging.network
      "${var.tagging.tag_key_prefix}:organization"    = var.tagging.organization
      "${var.tagging.tag_key_prefix}:resource:owner"  = var.tagging.owner
      "${var.tagging.tag_key_prefix}:service:name"    = var.naming.display
      "${var.tagging.tag_key_prefix}:service:pattern" = var.tagging.service_pattern
    })
  )
}
