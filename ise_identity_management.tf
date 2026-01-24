resource "ise_user_identity_group" "user_identity_group_0" {
  for_each = { for group in try(local.ise.identity_management.user_identity_groups, []) : group.name => group }

  name        = each.key
  description = try(each.value.description, local.defaults.ise.identity_management.user_identity_groups.description, null)
  parent      = try(each.value.parent_group, local.defaults.ise.identity_management.user_identity_groups.parent_group, null)
}

locals {
  user_identity_groups = distinct(flatten([
    for user in try(local.ise.identity_management.internal_users, []) : [
      for group in try(user.user_identity_groups, []) : group
    ]
  ]))
}

locals {
  user_identity_groups_children = flatten([for p in try(local.ise.identity_management.user_identity_groups, []) : [
    for c in try(p.children, []) : {
      name        = try(c.name, null)
      description = try(c.description, local.defaults.ise.identity_management.user_identity_groups.description, null)
      parent      = "${local.defaults.ise.identity_management.user_identity_groups.parent_group}:${p.name}"
    }
  ]])
}

resource "ise_user_identity_group" "user_identity_group_1" {
  for_each = { for group in local.user_identity_groups_children : group.name => group }

  name        = each.value.name
  description = each.value.description
  parent      = each.value.parent

  depends_on = [ise_user_identity_group.user_identity_group_0]
}

locals {
  user_identity_groups_children_children = flatten([for p in try(local.ise.identity_management.user_identity_groups, []) : [
    for c in try(p.children, []) : [
      for c2 in try(c.children, []) : {
        name        = try(c2.name, null)
        description = try(c2.description, local.defaults.ise.identity_management.user_identity_groups.description, null)
        parent      = "${local.defaults.ise.identity_management.user_identity_groups.parent_group}:${p.name}:${c.name}"
      }
    ]
  ]])
}

resource "ise_user_identity_group" "user_identity_group_2" {
  for_each = { for group in local.user_identity_groups_children_children : group.name => group }

  name        = each.value.name
  description = each.value.description
  parent      = each.value.parent

  depends_on = [ise_user_identity_group.user_identity_group_1]
}

locals {
  user_identity_groups_children_children_children = flatten([for p in try(local.ise.identity_management.user_identity_groups, []) : [
    for c in try(p.children, []) : [
      for c2 in try(c.children, []) : [
        for c3 in try(c2.children, []) : {
          name        = try(c3.name, null)
          description = try(c3.description, local.defaults.ise.identity_management.user_identity_groups.description, null)
          parent      = "${local.defaults.ise.identity_management.user_identity_groups.parent_group}:${p.name}:${c.name}:${c2.name}"
        }
      ]
    ]
  ]])
}

resource "ise_user_identity_group" "user_identity_group_3" {
  for_each = { for group in local.user_identity_groups_children_children_children : group.name => group }

  name        = each.value.name
  description = each.value.description
  parent      = each.value.parent

  depends_on = [ise_user_identity_group.user_identity_group_2]
}

locals {
  user_identity_groups_children_children_children_children = flatten([for p in try(local.ise.identity_management.user_identity_groups, []) : [
    for c in try(p.children, []) : [
      for c2 in try(c.children, []) : [
        for c3 in try(c2.children, []) : [
          for c4 in try(c3.children, []) : {
            name        = try(c4.name, null)
            description = try(c4.description, local.defaults.ise.identity_management.user_identity_groups.description, null)
            parent      = "${local.defaults.ise.identity_management.user_identity_groups.parent_group}:${p.name}:${c.name}:${c2.name}:${c3.name}"
          }
        ]
      ]
    ]
  ]])
}

resource "ise_user_identity_group" "user_identity_group_4" {
  for_each = { for group in local.user_identity_groups_children_children_children_children : group.name => group }

  name        = each.value.name
  description = each.value.description
  parent      = each.value.parent

  depends_on = [ise_user_identity_group.user_identity_group_3]
}

locals {
  user_identity_groups_children_children_children_children_children = flatten([for p in try(local.ise.identity_management.user_identity_groups, []) : [
    for c in try(p.children, []) : [
      for c2 in try(c.children, []) : [
        for c3 in try(c2.children, []) : [
          for c4 in try(c3.children, []) : [
            for c5 in try(c4.children, []) : {
              name        = try(c5.name, null)
              description = try(c5.description, local.defaults.ise.identity_management.user_identity_groups.description, null)
              parent      = "${local.defaults.ise.identity_management.user_identity_groups.parent_group}:${p.name}:${c.name}:${c2.name}:${c3.name}:${c4.name}"
            }
          ]
        ]
      ]
    ]
  ]])
}

resource "ise_user_identity_group" "user_identity_group_5" {
  for_each = { for group in local.user_identity_groups_children_children_children_children_children : group.name => group }

  name        = each.value.name
  description = each.value.description
  parent      = each.value.parent

  depends_on = [ise_user_identity_group.user_identity_group_4]
}

data "ise_user_identity_group" "user_identity_group" {
  for_each = toset(local.user_identity_groups)

  name = each.value

  depends_on = [ise_user_identity_group.user_identity_group_0, ise_user_identity_group.user_identity_group_1, ise_user_identity_group.user_identity_group_2, ise_user_identity_group.user_identity_group_3, ise_user_identity_group.user_identity_group_4, ise_user_identity_group.user_identity_group_5]
}

resource "ise_internal_user" "internal_user" {
  for_each = { for user in try(local.ise.identity_management.internal_users, []) : user.name => user }

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
  identity_groups        = length(try(each.value.user_identity_groups, [])) > 0 ? join(",", [for i in try(each.value.user_identity_groups, []) : data.ise_user_identity_group.user_identity_group[i].id]) : null
  password_never_expires = try(each.value.password_never_expires, local.defaults.ise.identity_management.internal_users.password_never_expires, null)
  password_id_store      = try(each.value.password_id_store, local.defaults.ise.identity_management.internal_users.password_id_store, null)

  depends_on = [ise_user_identity_group.user_identity_group_5]
}

locals {
  endpoint_identity_groups             = { for group in try(local.ise.identity_management.endpoint_identity_groups, []) : group.name => group }
  endpoint_identity_groups_with_parent = [for k, v in local.endpoint_identity_groups : v.parent_group if try(v.parent_group, "") != ""]
}


data "ise_endpoint_identity_group" "endpoint_identity_group" {
  for_each = toset(local.endpoint_identity_groups_with_parent)

  name = each.value
}

resource "ise_endpoint_identity_group" "endpoint_identity_group_0" {
  for_each = local.endpoint_identity_groups

  name                              = each.key
  parent_endpoint_identity_group_id = try(data.ise_endpoint_identity_group.endpoint_identity_group[each.value.parent_group].id, null)
  description                       = try(each.value.description, local.defaults.ise.identity_management.endpoint_identity_groups.description, null)
  system_defined                    = try(each.value.system_defined, local.defaults.ise.identity_management.endpoint_identity_groups.system_defined, null)
}

locals {
  endpoint_identity_groups_children = flatten([for p in try(local.ise.identity_management.endpoint_identity_groups, []) : [
    for c in try(p.children, []) : {
      name           = try(c.name, null)
      description    = try(c.description, local.defaults.ise.identity_management.endpoint_identity_groups.description, null)
      system_defined = try(c.system_defined, local.defaults.ise.identity_management.endpoint_identity_groups.system_defined, null)

      parent = try(p.name, null)
    }
  ]])
}

resource "ise_endpoint_identity_group" "endpoint_identity_group_1" {
  for_each = { for group in local.endpoint_identity_groups_children : group.name => group }

  name                              = each.key
  parent_endpoint_identity_group_id = try(ise_endpoint_identity_group.endpoint_identity_group_0[each.value.parent].id, null)
  description                       = each.value.description
  system_defined                    = each.value.system_defined

  depends_on = [ise_endpoint_identity_group.endpoint_identity_group_0]
}

locals {
  endpoint_identity_groups_children_children = flatten([for p in try(local.ise.identity_management.endpoint_identity_groups, []) : [
    for c in try(p.children, []) : [
      for c2 in try(c.children, []) : {
        name           = try(c2.name, null)
        description    = try(c2.description, local.defaults.ise.identity_management.endpoint_identity_groups.description, null)
        system_defined = try(c2.system_defined, local.defaults.ise.identity_management.endpoint_identity_groups.system_defined, null)
        parent         = try(c.name, null)
      }
    ]
  ]])
}

resource "ise_endpoint_identity_group" "endpoint_identity_group_2" {
  for_each = { for group in local.endpoint_identity_groups_children_children : group.name => group }

  name                              = each.key
  parent_endpoint_identity_group_id = try(ise_endpoint_identity_group.endpoint_identity_group_1[each.value.parent].id, null)
  description                       = each.value.description
  system_defined                    = each.value.system_defined

  depends_on = [ise_endpoint_identity_group.endpoint_identity_group_1]
}

locals {
  endpoint_identity_groups_children_children_children = flatten([for p in try(local.ise.identity_management.endpoint_identity_groups, []) : [
    for c in try(p.children, []) : [
      for c2 in try(c.children, []) : [
        for c3 in try(c2.children, []) : {
          name           = try(c3.name, null)
          description    = try(c3.description, local.defaults.ise.identity_management.endpoint_identity_groups.description, null)
          system_defined = try(c3.system_defined, local.defaults.ise.identity_management.endpoint_identity_groups.system_defined, null)
          parent         = try(c2.name, null)
        }
      ]
    ]
  ]])
}

resource "ise_endpoint_identity_group" "endpoint_identity_group_3" {
  for_each = { for group in local.endpoint_identity_groups_children_children_children : group.name => group }

  name                              = each.key
  parent_endpoint_identity_group_id = try(ise_endpoint_identity_group.endpoint_identity_group_2[each.value.parent].id, null)
  description                       = each.value.description
  system_defined                    = each.value.system_defined

  depends_on = [ise_endpoint_identity_group.endpoint_identity_group_2]
}

locals {
  endpoint_identity_groups_children_children_children_children = flatten([for p in try(local.ise.identity_management.endpoint_identity_groups, []) : [
    for c in try(p.children, []) : [
      for c2 in try(c.children, []) : [
        for c3 in try(c2.children, []) : [
          for c4 in try(c3.children, []) : {
            name           = try(c4.name, null)
            description    = try(c4.description, local.defaults.ise.identity_management.endpoint_identity_groups.description, null)
            system_defined = try(c4.system_defined, local.defaults.ise.identity_management.endpoint_identity_groups.system_defined, null)
            parent         = try(c3.name, null)
          }
        ]
      ]
    ]
  ]])
}

resource "ise_endpoint_identity_group" "endpoint_identity_group_4" {
  for_each = { for group in local.endpoint_identity_groups_children_children_children_children : group.name => group }

  name                              = each.key
  parent_endpoint_identity_group_id = try(ise_endpoint_identity_group.endpoint_identity_group_3[each.value.parent].id, null)
  description                       = each.value.description
  system_defined                    = each.value.system_defined

  depends_on = [ise_endpoint_identity_group.endpoint_identity_group_3]
}

locals {
  endpoint_identity_groups_children_children_children_children_children = flatten([for p in try(local.ise.identity_management.endpoint_identity_groups, []) : [
    for c in try(p.children, []) : [
      for c2 in try(c.children, []) : [
        for c3 in try(c2.children, []) : [
          for c4 in try(c3.children, []) : [
            for c5 in try(c4.children, []) : {
              name           = try(c5.name, null)
              description    = try(c5.description, local.defaults.ise.identity_management.endpoint_identity_groups.description, null)
              parent         = try(c4.name, null)
              system_defined = try(c5.system_defined, local.defaults.ise.identity_management.endpoint_identity_groups.system_defined, null)

            }
          ]
        ]
      ]
    ]
  ]])
}

resource "ise_endpoint_identity_group" "endpoint_identity_group_5" {
  for_each = { for group in local.endpoint_identity_groups_children_children_children_children_children : group.name => group }

  name                              = each.key
  parent_endpoint_identity_group_id = try(ise_endpoint_identity_group.endpoint_identity_group_4[each.value.parent].id, null)
  description                       = each.value.description
  system_defined                    = each.value.system_defined

  depends_on = [ise_endpoint_identity_group.endpoint_identity_group_4]
}

locals {
  endpoint_identity_groups_all = merge(
    { for k, v in ise_endpoint_identity_group.endpoint_identity_group_0 : k => v.id },
    { for k, v in ise_endpoint_identity_group.endpoint_identity_group_1 : k => v.id },
    { for k, v in ise_endpoint_identity_group.endpoint_identity_group_2 : k => v.id },
    { for k, v in ise_endpoint_identity_group.endpoint_identity_group_3 : k => v.id },
    { for k, v in ise_endpoint_identity_group.endpoint_identity_group_4 : k => v.id },
    { for k, v in ise_endpoint_identity_group.endpoint_identity_group_5 : k => v.id }
  )
}

resource "ise_endpoint" "endpoint" {
  for_each = { for endpoint in try(local.ise.identity_management.endpoints, []) : endpoint.mac => endpoint }

  name                              = each.key
  mac                               = each.key
  description                       = try(each.value.description, local.defaults.ise.identity_management.endpoints.description, null)
  static_profile_assignment         = try(each.value.static_profile_assignment, local.defaults.ise.identity_management.endpoints.static_profile_assignment, null)
  static_group_assignment           = try(each.value.static_group_assignment, local.defaults.ise.identity_management.endpoints.static_group_assignment, null)
  group_id                          = try(each.value.static_group_assignment, false) ? try(local.endpoint_identity_groups_all[each.value.endpoint_identity_group], data.ise_endpoint_identity_group.endpoint_identity_group[each.value.endpoint_identity_group].id, null) : null
  static_profile_assignment_defined = try(each.value.static_profile_assignment_defined, local.defaults.ise.identity_management.endpoints.static_profile_assignment_defined, null)
  static_group_assignment_defined   = try(each.value.static_group_assignment_defined, local.defaults.ise.identity_management.endpoints.static_group_assignment_defined, null)
  identity_store                    = try(each.value.identity_store, local.defaults.ise.identity_management.endpoints.identity_store, null)
  identity_store_id                 = try(each.value.identity_store_id, local.defaults.ise.identity_management.endpoints.identity_store_id, null)
  portal_user                       = try(each.value.portal_user, local.defaults.ise.identity_management.endpoints.portal_user, null)
  profile_id                        = try(each.value.static_profile_assignment, false) ? try(each.value.profile_id, local.defaults.ise.identity_management.endpoints.profile_id, null) : null
  custom_attributes                 = try(each.value.custom_attributes, local.defaults.ise.identity_management.endpoints.custom_attributes, null)
  mdm_compliance_status             = try(each.value.mdm_attributes.compliance_status, local.defaults.ise.identity_management.endpoints.mdm_attributes.compliance_status, null)
  mdm_encrypted                     = try(each.value.mdm_attributes.encrypted, local.defaults.ise.identity_management.endpoints.mdm_attributes.encrypted, null)
  mdm_enrolled                      = try(each.value.mdm_attributes.enrolled, local.defaults.ise.identity_management.endpoints.mdm_attributes.enrolled, null)
  mdm_imei                          = try(each.value.mdm_attributes.imei, local.defaults.ise.identity_management.endpoints.mdm_attributes.imei, null)
  mdm_jail_broken                   = try(each.value.mdm_attributes.jail_broken, local.defaults.ise.identity_management.endpoints.mdm_attributes.jail_broken, null)
  mdm_manufacturer                  = try(each.value.mdm_attributes.manufacturer, local.defaults.ise.identity_management.endpoints.mdm_attributes.manufacturer, null)
  mdm_model                         = try(each.value.mdm_attributes.model, local.defaults.ise.identity_management.endpoints.mdm_attributes.model, null)
  mdm_os                            = try(each.value.mdm_attributes.os, local.defaults.ise.identity_management.endpoints.mdm_attributes.os, null)
  mdm_phone_number                  = try(each.value.mdm_attributes.phone_number, local.defaults.ise.identity_management.endpoints.mdm_attributes.phone_number, null)
  mdm_pinlock                       = try(each.value.mdm_attributes.pin_lock, local.defaults.ise.identity_management.endpoints.mdm_attributes.pin_lock, null)
  mdm_reachable                     = try(each.value.mdm_attributes.reachable, local.defaults.ise.identity_management.endpoints.mdm_attributes.reachable, null)
  mdm_serial                        = try(each.value.mdm_attributes.serial, local.defaults.ise.identity_management.endpoints.mdm_attributes.serial, null)
  mdm_server_name                   = try(each.value.mdm_attributes.server_name, local.defaults.ise.identity_management.endpoints.mdm_attributes.server_name, null)

  depends_on = [ise_endpoint_identity_group.endpoint_identity_group_5]
}

resource "ise_certificate_authentication_profile" "certificate_authentication_profile" {
  for_each = { for profile in try(local.ise.identity_management.certificate_authentication_profiles, []) : profile.name => profile }

  name                         = each.key
  description                  = try(each.value.description, local.defaults.ise.identity_management.certificate_authentication_profiles.description, null)
  allowed_as_user_name         = try(each.value.allowed_as_user_name, local.defaults.ise.identity_management.certificate_authentication_profiles.description, null)
  certificate_attribute_name   = try(each.value.certificate_attribute_name, local.defaults.ise.identity_management.certificate_authentication_profiles.description, null)
  external_identity_store_name = try(each.value.external_identity_store_name, local.defaults.ise.identity_management.certificate_authentication_profiles.description, null)
  match_mode                   = try(each.value.match_mode, local.defaults.ise.identity_management.certificate_authentication_profiles.description, null)
  username_from                = try(each.value.username_from, local.defaults.ise.identity_management.certificate_authentication_profiles.description, null)
}

resource "ise_active_directory_join_point" "active_directory_join_point" {
  for_each = { for ad in try(local.ise.identity_management.active_directories, []) : ad.name => ad }

  name                       = each.key
  description                = try(each.value.description, local.defaults.ise.identity_management.active_directories.description, null)
  domain                     = try(each.value.domain, local.defaults.ise.identity_management.active_directories.domain, null)
  ad_scopes_names            = try(each.value.ad_scopes_names, local.defaults.ise.identity_management.active_directories.ad_scopes_names, null)
  enable_domain_allowed_list = try(each.value.enable_domain_allowed_list, local.defaults.ise.identity_management.active_directories.enable_domain_allowed_list, null)
  groups                     = []
  attributes = [for attr in try(each.value.attributes, []) : {
    name          = try(attr.name, null)
    type          = try(attr.type, local.defaults.ise.identity_management.active_directories.attributes.type, null)
    internal_name = try(attr.internal_name, local.defaults.ise.identity_management.active_directories.attributes.internal_name, null)
    default_value = try(attr.default_value, local.defaults.ise.identity_management.active_directories.attributes.default_value, null)
  }]
  rewrite_rules = [for rule in try(each.value.rewrite_rules, []) : {
    row_id         = try(rule.row_id, local.defaults.ise.identity_management.active_directories.rewrite_rules.row_id, null)
    rewrite_match  = try(rule.rewrite_match, local.defaults.ise.identity_management.active_directories.rewrite_rules.rewrite_match, null)
    rewrite_result = try(rule.rewrite_result, local.defaults.ise.identity_management.active_directories.rewrite_rules.rewrite_result, null)
  }]
  enable_rewrites                   = try(each.value.enable_rewrites, local.defaults.ise.identity_management.active_directories.enable_rewrites, null)
  enable_pass_change                = try(each.value.enable_pass_change, local.defaults.ise.identity_management.active_directories.enable_pass_change, null)
  enable_machine_auth               = try(each.value.enable_machine_auth, local.defaults.ise.identity_management.active_directories.enable_machine_auth, null)
  enable_machine_access             = try(each.value.enable_machine_access, local.defaults.ise.identity_management.active_directories.enable_machine_access, null)
  enable_dialin_permission_check    = try(each.value.enable_dialin_permission_check, local.defaults.ise.identity_management.active_directories.enable_dialin_permission_check, null)
  plaintext_auth                    = try(each.value.plaintext_auth, local.defaults.ise.identity_management.active_directories.plaintext_auth, null)
  aging_time                        = try(each.value.aging_time, local.defaults.ise.identity_management.active_directories.aging_time, null)
  enable_callback_for_dialin_client = try(each.value.enable_callback_for_dialin_client, local.defaults.ise.identity_management.active_directories.enable_callback_for_dialin_client, null)
  identity_not_in_ad_behaviour      = try(each.value.identity_not_in_ad_behaviour, local.defaults.ise.identity_management.active_directories.identity_not_in_ad_behaviour, null)
  unreachable_domains_behaviour     = try(each.value.unreachable_domains_behaviour, local.defaults.ise.identity_management.active_directories.unreachable_domains_behaviour, null)
  schema                            = try(each.value.schema, local.defaults.ise.identity_management.active_directories.schema, null)
  first_name                        = try(each.value.first_name, local.defaults.ise.identity_management.active_directories.first_name, null)
  department                        = try(each.value.department, local.defaults.ise.identity_management.active_directories.department, null)
  last_name                         = try(each.value.last_name, local.defaults.ise.identity_management.active_directories.last_name, null)
  organizational_unit               = try(each.value.organizational_unit, local.defaults.ise.identity_management.active_directories.organizational_unit, null)
  job_title                         = try(each.value.job_title, local.defaults.ise.identity_management.active_directories.job_title, null)
  locality                          = try(each.value.locality, local.defaults.ise.identity_management.active_directories.locality, null)
  email                             = try(each.value.email, local.defaults.ise.identity_management.active_directories.email, null)
  state_or_province                 = try(each.value.state_or_province, local.defaults.ise.identity_management.active_directories.state_or_province, null)
  telephone                         = try(each.value.telephone, local.defaults.ise.identity_management.active_directories.telephone, null)
  country                           = try(each.value.country, local.defaults.ise.identity_management.active_directories.country, null)
  street_address                    = try(each.value.street_address, local.defaults.ise.identity_management.active_directories.street_address, null)
  enable_failed_auth_protection     = try(each.value.enable_failed_auth_protection, local.defaults.ise.identity_management.active_directories.enable_failed_auth_protection, null)
  failed_auth_threshold             = try(each.value.failed_auth_threshold, local.defaults.ise.identity_management.active_directories.failed_auth_threshold, null)
  auth_protection_type              = try(each.value.auth_protection_type, local.defaults.ise.identity_management.active_directories.auth_protection_type, null)
}

resource "ise_active_directory_join_domain_with_all_nodes" "active_directory_join_domain_with_all_nodes" {
  for_each = {
    for ad in try(local.ise.identity_management.active_directories, []) : ad.name => ad
    if try(ad.join_domain, local.defaults.ise.identity_management.active_directories.join_domain, true) == true
  }

  join_point_id = ise_active_directory_join_point.active_directory_join_point[each.key].id
  additional_data = [
    {
      name  = "username"
      value = try(each.value.ad_username, local.defaults.ise.identity_management.active_directories.ad_username, null)
    },
    {
      name  = "password"
      value = try(each.value.ad_password, local.defaults.ise.identity_management.active_directories.ad_password, null)
    }
  ]

  depends_on = [ise_active_directory_join_point.active_directory_join_point]
}

locals {
  # Determine which ADs need group lookup
  # Lookup is needed when groups don't have SID provided
  ad_groups_need_lookup = {
    for ad in try(local.ise.identity_management.active_directories, []) : ad.name => ad
    if length(try(ad.groups, [])) > 0 && anytrue([
      for group in try(ad.groups, []) :
      # If group doesn't have sid field, we need lookup
      try(group.sid, null) == null
    ])
  }
}

data "ise_active_directory_groups_by_domain" "all_groups" {
  for_each = local.ad_groups_need_lookup

  join_point_id = ise_active_directory_join_point.active_directory_join_point[each.key].id
  domain        = try(each.value.domain, local.defaults.ise.identity_management.active_directories.domain, null)

  # Depend on join only if join_domain is true for this AD
  depends_on = [
    ise_active_directory_join_point.active_directory_join_point,
    ise_active_directory_join_domain_with_all_nodes.active_directory_join_domain_with_all_nodes
  ]
}

locals {
  active_directory_groups_all = {
    for k, v in data.ise_active_directory_groups_by_domain.all_groups :
    k => { for group in v.groups : group.name => group }
  }

  active_directory_groups = {
    for ad in try(local.ise.identity_management.active_directories, []) : ad.name => [
      for group in try(ad.groups, []) : {
        # Groups are always objects now with optional sid field
        # If sid not provided, lookup from data source
        name = group.name
        sid  = try(group.sid, local.active_directory_groups_all[ad.name][group.name].sid)
        type = try(group.type, local.active_directory_groups_all[ad.name][group.name].type, null)
      }
    ]
  }
}

resource "ise_active_directory_add_groups" "active_directory_groups" {
  for_each = {
    for ad in try(local.ise.identity_management.active_directories, []) : ad.name => ad
    if length(try(ad.groups, [])) > 0
  }

  join_point_id              = ise_active_directory_join_point.active_directory_join_point[each.key].id
  name                       = ise_active_directory_join_point.active_directory_join_point[each.key].name
  description                = ise_active_directory_join_point.active_directory_join_point[each.key].description
  domain                     = ise_active_directory_join_point.active_directory_join_point[each.key].domain
  ad_scopes_names            = ise_active_directory_join_point.active_directory_join_point[each.key].ad_scopes_names
  enable_domain_allowed_list = ise_active_directory_join_point.active_directory_join_point[each.key].enable_domain_allowed_list
  groups                     = try(local.active_directory_groups[each.key], local.defaults.ise.identity_management.active_directories.groups, null)

  depends_on = [
    ise_active_directory_join_point.active_directory_join_point,
    ise_active_directory_join_domain_with_all_nodes.active_directory_join_domain_with_all_nodes,
    data.ise_active_directory_groups_by_domain.all_groups
  ]
}

resource "ise_identity_source_sequence" "identity_source_sequences" {
  for_each = { for sequence in try(local.ise.identity_management.identity_source_sequences, []) : sequence.name => sequence }

  name                               = each.key
  description                        = try(each.value.description, local.defaults.ise.identity_management.identity_source_sequences.description, null)
  break_on_store_fail                = try(each.value.break_on_store_fail, local.defaults.ise.identity_management.identity_source_sequences.break_on_store_fail, null)
  certificate_authentication_profile = try(each.value.certificate_authentication_profile, local.defaults.ise.identity_management.identity_source_sequences.certificate_authentication_profile, null)
  identity_sources = [for index, identity_source in try(each.value.identity_sources, []) : {
    name  = try(identity_source, local.defaults.ise.identity_management.identity_source_sequences.identity_sources, null)
    order = index + 1
  }]

  depends_on = [ise_active_directory_join_point.active_directory_join_point]
}
