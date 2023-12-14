resource "ise_user_identity_group" "user_identity_group" {
  for_each = { for group in try(local.ise.identity_management.user_identity_groups, []) : group.name => group if var.manage_identity_management }

  name        = each.key
  description = try(each.value.description, local.defaults.ise.identity_management.user_identity_groups.description, null)
}

resource "ise_internal_user" "internal_user" {
  for_each = { for user in try(local.ise.identity_management.internal_users, []) : user.name => user if var.manage_identity_management }

  name                   = each.key
  description            = try(each.value.description, local.defaults.ise.identity_management.internal_users.description, null)
  enabled                = try(each.value.enabled, local.defaults.ise.identity_management.internal_users.enabled, null)
  email                  = try(each.value.email, local.defaults.ise.identity_management.internal_users.email, null)
  account_name_alias     = try(each.value.account_name_alias, local.defaults.ise.identity_management.internal_users.account_name_alias, null)
  password               = try(each.value.password, local.defaults.ise.identity_management.internal_users.password, null)
  enable_password        = try(each.value.enable_password, local.defaults.ise.identity_management.internal_users.enable_password, null)
  first_name             = try(each.value.first_name, local.defaults.ise.identity_management.internal_users.first_name, null)
  last_name              = try(each.value.last_name, local.defaults.ise.identity_management.internal_users.last_name, null)
  change_password        = try(each.value.change_password, local.defaults.ise.identity_management.internal_users.change_password, null)
  identity_groups        = length(try(each.value.user_identity_groups, [])) > 0 ? join(",", [for i in try(each.value.user_identity_groups, []) : ise_user_identity_group.user_identity_group[i].id]) : null
  password_never_expires = try(each.value.password_never_expires, local.defaults.ise.identity_management.internal_users.password_never_expires, null)
  password_id_store      = try(each.value.password_id_store, local.defaults.ise.identity_management.internal_users.password_id_store, null)
}

locals {
  endpoint_identity_groups             = { for group in try(local.ise.identity_management.endpoint_identity_groups, []) : group.name => group if var.manage_identity_management }
  endpoint_identity_groups_with_parent = { for k, v in local.endpoint_identity_groups : k => v if try(v.parent_group, "") != "" && var.manage_identity_management }
}

data "ise_endpoint_identity_group" "endpoint_identity_group" {
  for_each = local.endpoint_identity_groups_with_parent

  name = each.value.parent_group
}

resource "ise_endpoint_identity_group" "endpoint_identity_group" {
  for_each = local.endpoint_identity_groups

  name                              = each.key
  parent_endpoint_identity_group_id = try(data.ise_endpoint_identity_group.endpoint_identity_group[each.key].id, null)
  description                       = try(each.value.description, local.defaults.ise.identity_management.endpoint_identity_groups.description, null)
}

resource "ise_certificate_authentication_profile" "certificate_authentication_profile" {
  for_each = { for profile in try(local.ise.identity_management.certificate_authentication_profiles, []) : profile.name => profile if var.manage_identity_management }

  name                         = each.key
  description                  = try(each.value.description, local.defaults.ise.identity_management.certificate_authentication_profiles.description, null)
  allowed_as_user_name         = try(each.value.allowed_as_user_name, local.defaults.ise.identity_management.certificate_authentication_profiles.description, null)
  certificate_attribute_name   = try(each.value.certificate_attribute_name, local.defaults.ise.identity_management.certificate_authentication_profiles.description, null)
  external_identity_store_name = try(each.value.external_identity_store_name, local.defaults.ise.identity_management.certificate_authentication_profiles.description, null)
  match_mode                   = try(each.value.match_mode, local.defaults.ise.identity_management.certificate_authentication_profiles.description, null)
  username_from                = try(each.value.username_from, local.defaults.ise.identity_management.certificate_authentication_profiles.description, null)
}
