locals {
  device_admin_conditions_circular_names = distinct(flatten([
    for v in try(local.ise.device_administration.policy_elements.conditions, []) : [
      for v2 in try(v.children, []) : try(v2.type, null) == "ConditionReference" ? [[v2.name]] : [
        for v3 in try(v2.children, []) : try(v3.type, null) == "ConditionReference" ? [v3.name] : []
      ]
    ]
  ]))
}

data "ise_device_admin_condition" "device_admin_condition_circular" {
  for_each = toset(local.device_admin_conditions_circular_names)

  name = each.value
}

resource "ise_device_admin_condition" "device_admin_condition" {
  for_each = { for condition in try(local.ise.device_administration.policy_elements.conditions, []) : condition.name => condition }

  condition_type   = try(each.value.type, local.defaults.ise.device_administration.policy_elements.conditions.type, null)
  is_negate        = try(each.value.is_negate, local.defaults.ise.device_administration.policy_elements.conditions.is_negate, null)
  attribute_name   = try(each.value.attribute_name, local.defaults.ise.device_administration.policy_elements.conditions.attribute_name, null)
  attribute_value  = try(each.value.attribute_value, local.defaults.ise.device_administration.policy_elements.conditions.attribute_value, null)
  dictionary_name  = try(each.value.dictionary_name, local.defaults.ise.device_administration.policy_elements.conditions.dictionary_name, null)
  dictionary_value = try(each.value.dictionary_value, local.defaults.ise.device_administration.policy_elements.conditions.dictionary_value, null)
  operator         = try(each.value.operator, local.defaults.ise.device_administration.policy_elements.conditions.operator, null)
  description      = try(each.value.description, local.defaults.ise.device_administration.policy_elements.conditions.description, null)
  name             = each.key
  children = length(try(each.value.children, [])) == 0 ? null : [for c in try(each.value.children, []) : {
    attribute_name   = try(c.attribute_name, local.defaults.ise.device_administration.policy_elements.conditions.attribute_name, null)
    attribute_value  = try(c.attribute_value, local.defaults.ise.device_administration.policy_elements.conditions.attribute_value, null)
    dictionary_name  = try(c.dictionary_name, local.defaults.ise.device_administration.policy_elements.conditions.dictionary_name, null)
    dictionary_value = try(c.dictionary_value, local.defaults.ise.device_administration.policy_elements.conditions.dictionary_value, null)
    condition_type   = try(c.type, local.defaults.ise.device_administration.policy_elements.conditions.type, null)
    is_negate        = try(c.is_negate, local.defaults.ise.device_administration.policy_elements.conditions.is_negate, null)
    operator         = try(c.operator, local.defaults.ise.device_administration.policy_elements.conditions.operator, null)
    name             = try(c.name, null)
    id               = try(c.type, local.defaults.ise.device_administration.policy_elements.conditions.type, null) == "ConditionReference" ? data.ise_device_admin_condition.device_admin_condition_circular[c.name].id : null
    children = length(try(c.children, [])) == 0 ? null : [for c2 in try(c.children, []) : {
      attribute_name   = try(c2.attribute_name, local.defaults.ise.device_administration.policy_elements.conditions.attribute_name, null)
      attribute_value  = try(c2.attribute_value, local.defaults.ise.device_administration.policy_elements.conditions.attribute_value, null)
      dictionary_name  = try(c2.dictionary_name, local.defaults.ise.device_administration.policy_elements.conditions.dictionary_name, null)
      dictionary_value = try(c2.dictionary_value, local.defaults.ise.device_administration.policy_elements.conditions.dictionary_value, null)
      condition_type   = try(c2.type, local.defaults.ise.device_administration.policy_elements.conditions.type, null)
      is_negate        = try(c2.is_negate, local.defaults.ise.device_administration.policy_elements.conditions.is_negate, null)
      operator         = try(c2.operator, local.defaults.ise.device_administration.policy_elements.conditions.operator, null)
      name             = try(c2.name, null)
      id               = try(c2.type, local.defaults.ise.device_administration.policy_elements.conditions.type, null) == "ConditionReference" ? data.ise_device_admin_condition.device_admin_condition_circular[c2.name].id : null
    }]
  }]

  depends_on = [ise_network_device_group.network_device_group_5, ise_active_directory_add_groups.active_directory_groups]
}

resource "ise_allowed_protocols_tacacs" "allowed_protocols_tacacs" {
  for_each = { for protocol in try(local.ise.device_administration.policy_elements.allowed_protocols, []) : protocol.name => protocol }

  description      = try(each.value.description, "")
  name             = each.key
  allow_pap_ascii  = try(each.value.allow_pap_ascii, local.defaults.ise.device_administration.policy_elements.allowed_protocols.allow_pap_ascii, null)
  allow_chap       = try(each.value.allow_chap, local.defaults.ise.device_administration.policy_elements.allowed_protocols.allow_chap, null)
  allow_ms_chap_v1 = try(each.value.allow_ms_chap_v1, local.defaults.ise.device_administration.policy_elements.allowed_protocols.allow_ms_chap_v1, null)
}

resource "ise_tacacs_profile" "tacacs_profile" {
  for_each = { for profile in try(local.ise.device_administration.policy_elements.tacacs_profiles, []) : profile.name => profile }

  name        = each.key
  description = try(each.value.description, local.defaults.ise.device_administration.policy_elements.tacacs_profiles.description, null)
  session_attributes = try([for i in each.value.session_attributes : {
    type  = try(i.type, local.defaults.ise.device_administration.policy_elements.tacacs_profiles.session_attributes.type, null)
    name  = try(i.name, local.defaults.ise.device_administration.policy_elements.tacacs_profiles.session_attributes.name, null)
    value = try(i.value, local.defaults.ise.device_administration.policy_elements.tacacs_profiles.session_attributes.value, null)
  }], null)
}

resource "ise_tacacs_command_set" "tacacs_command_set" {
  for_each = { for cs in try(local.ise.device_administration.policy_elements.tacacs_command_sets, []) : cs.name => cs }

  name             = each.key
  description      = try(each.value.description, local.defaults.ise.device_administration.policy_elements.tacacs_command_sets.description, null)
  permit_unmatched = try(each.value.permit_unmatched, local.defaults.ise.device_administration.policy_elements.tacacs_command_sets.permit_unmatched, null)
  commands = try([for i in each.value.commands : {
    grant     = try(i.grant, local.defaults.ise.device_administration.policy_elements.tacacs_command_sets.commands.grant, null)
    command   = try(i.command, local.defaults.ise.device_administration.policy_elements.tacacs_command_sets.commands.command, null)
    arguments = try(i.arguments, local.defaults.ise.device_administration.policy_elements.tacacs_command_sets.commands.arguments, "")
  }], null)
}

resource "ise_device_admin_time_and_date_condition" "device_admin_time_and_date_condition" {
  for_each = { for c in try(local.ise.device_administration.policy_elements.time_date_conditions, []) : c.name => c }

  name                 = each.key
  description          = try(each.value.description, local.defaults.ise.device_administration.policy_elements.time_date_conditions.description, null)
  week_days            = try(each.value.week_days, local.defaults.ise.device_administration.policy_elements.time_date_conditions.week_days, null)
  week_days_exception  = try(each.value.week_days_exception, local.defaults.ise.device_administration.policy_elements.time_date_conditions.week_days_exception, null)
  start_date           = try(each.value.start_date, local.defaults.ise.device_administration.policy_elements.time_date_conditions.start_date, null)
  end_date             = try(each.value.end_date, local.defaults.ise.device_administration.policy_elements.time_date_conditions.end_date, null)
  exception_start_date = try(each.value.exception_start_date, local.defaults.ise.device_administration.policy_elements.time_date_conditions.exception_start_date, null)
  exception_end_date   = try(each.value.exception_end_date, local.defaults.ise.device_administration.policy_elements.time_date_conditions.exception_end_date, null)
  start_time           = try(each.value.start_time, local.defaults.ise.device_administration.policy_elements.time_date_conditions.start_time, null)
  end_time             = try(each.value.end_time, local.defaults.ise.device_administration.policy_elements.time_date_conditions.end_time, null)
  exception_start_time = try(each.value.exception_start_time, local.defaults.ise.device_administration.policy_elements.time_date_conditions.exception_start_time, null)
  exception_end_time   = try(each.value.exception_end_time, local.defaults.ise.device_administration.policy_elements.time_date_conditions.exception_end_time, null)
}

locals {
  conditions_device_admin_policy_sets = flatten([
    for v in try(local.ise.device_administration.policy_sets, []) : try(v.condition.type, null) == "ConditionReference" ? [[[v.condition.name]]] : [
      for v2 in try(v.condition.children, []) : try(v2.type, null) == "ConditionReference" ? [[v2.name]] : [
        for v3 in try(v2.children, []) : try(v3.type, null) == "ConditionReference" ? [v3.name] : []
      ]
    ]
  ])
  conditions_device_admin_policy_set_authentication_rules = flatten([
    for v in try(local.ise.device_administration.policy_sets, []) : [
      for r in try(v.authentication_rules, []) : try(r.condition.type, null) == "ConditionReference" ? [[[r.condition.name]]] : [
        for v2 in try(r.condition.children, []) : try(v2.type, null) == "ConditionReference" ? [[v2.name]] : [
          for v3 in try(v2.children, []) : try(v3.type, null) == "ConditionReference" ? [v3.name] : []
        ]
      ]
    ]
  ])
  conditions_device_admin_policy_set_authorization_rules = flatten([
    for v in try(local.ise.device_administration.policy_sets, []) : [
      for r in try(v.authorization_rules, []) : try(r.condition.type, null) == "ConditionReference" ? [[[r.condition.name]]] : [
        for v2 in try(r.condition.children, []) : try(v2.type, null) == "ConditionReference" ? [[v2.name]] : [
          for v3 in try(v2.children, []) : try(v3.type, null) == "ConditionReference" ? [v3.name] : []
        ]
      ]
    ]
  ])
  conditions_device_admin_policy_set_authorization_exception_rules = flatten([
    for v in try(local.ise.device_administration.policy_sets, []) : [
      for r in try(v.authorization_exception_rules, []) : try(r.condition.type, null) == "ConditionReference" ? [[[r.condition.name]]] : [
        for v2 in try(r.condition.children, []) : try(v2.type, null) == "ConditionReference" ? [[v2.name]] : [
          for v3 in try(v2.children, []) : try(v3.type, null) == "ConditionReference" ? [v3.name] : []
        ]
      ]
    ]
  ])
  conditions_device_admin_authorization_global_exception_rules = flatten([
    for v in try(local.ise.device_administration.authorization_global_exception_rules, []) : try(v.condition.type, null) == "ConditionReference" ? [[[v.condition.name]]] : [
      for v2 in try(v.condition.children, []) : try(v2.type, null) == "ConditionReference" ? [[v2.name]] : [
        for v3 in try(v2.children, []) : try(v3.type, null) == "ConditionReference" ? [v3.name] : []
      ]
    ]
  ])
  unique_conditions_device_admin  = distinct(concat(local.conditions_device_admin_policy_sets, local.conditions_device_admin_policy_set_authentication_rules, local.conditions_device_admin_policy_set_authorization_rules, local.conditions_device_admin_policy_set_authorization_exception_rules, local.conditions_device_admin_authorization_global_exception_rules))
  known_conditions_device_admin   = [for condition in try(local.ise.device_administration.policy_elements.conditions, []) : condition.name]
  unknown_conditions_device_admin = setsubtract(local.unique_conditions_device_admin, local.known_conditions_device_admin)
}

data "ise_device_admin_condition" "device_admin_condition" {
  for_each = toset(local.unknown_conditions_device_admin)

  name = each.value
}

locals {
  device_admin_policy_sets = [
    for ps in try(local.ise.device_administration.policy_sets, []) : {
      condition_type             = ps.name == "Default" ? null : try(ps.condition.type, local.defaults.ise.device_administration.policy_sets.condition.type, null)
      condition_is_negate        = ps.name == "Default" ? null : try(ps.condition.is_negate, local.defaults.ise.device_administration.policy_sets.condition.is_negate, null)
      condition_attribute_name   = ps.name == "Default" ? null : try(ps.condition.attribute_name, local.defaults.ise.device_administration.policy_sets.condition.attribute_name, null)
      condition_attribute_value  = ps.name == "Default" ? null : try(ps.condition.attribute_value, local.defaults.ise.device_administration.policy_sets.condition.attribute_value, null)
      condition_dictionary_name  = ps.name == "Default" ? null : try(ps.condition.dictionary_name, local.defaults.ise.device_administration.policy_sets.condition.dictionary_name, null)
      condition_dictionary_value = ps.name == "Default" ? null : try(ps.condition.dictionary_value, local.defaults.ise.device_administration.policy_sets.condition.dictionary_value, null)
      condition_id               = contains(local.known_conditions_device_admin, try(ps.condition.name, "")) ? ise_device_admin_condition.device_admin_condition[ps.condition.name].id : try(data.ise_device_admin_condition.device_admin_condition[ps.condition.name].id, null)
      condition_operator         = ps.name == "Default" ? null : try(ps.condition.operator, local.defaults.ise.device_administration.policy_sets.condition.operator, null)
      description                = try(ps.description, local.defaults.ise.device_administration.policy_sets.description, null)
      is_proxy                   = try(ps.is_proxy, local.defaults.ise.device_administration.policy_sets.is_proxy)
      name                       = ps.name
      service_name               = try(ps.service_name, local.defaults.ise.device_administration.policy_sets.service_name)
      state                      = try(ps.state, local.defaults.ise.device_administration.policy_sets.state)
      default                    = ps.name == "Default" ? true : false
      rank                       = try(ps.rank, local.defaults.ise.device_administration.policy_sets.rank, null)
      children = try([for i in ps.condition.children : {
        attribute_name   = try(i.attribute_name, local.defaults.ise.device_administration.policy_sets.condition.attribute_name, null)
        attribute_value  = try(i.attribute_value, local.defaults.ise.device_administration.policy_sets.condition.attribute_value, null)
        dictionary_name  = try(i.dictionary_name, local.defaults.ise.device_administration.policy_sets.condition.dictionary_name, null)
        dictionary_value = try(i.dictionary_value, local.defaults.ise.device_administration.policy_sets.condition.dictionary_value, null)
        condition_type   = try(i.type, local.defaults.ise.device_administration.policy_sets.condition.type, null)
        is_negate        = try(i.is_negate, local.defaults.ise.device_administration.policy_sets.condition.is_negate, null)
        operator         = try(i.operator, local.defaults.ise.device_administration.policy_sets.condition.operator, null)
        id               = contains(local.known_conditions_device_admin, try(i.name, "")) ? ise_device_admin_condition.device_admin_condition[i.name].id : try(data.ise_device_admin_condition.device_admin_condition[i.name].id, null)
        children = try([for j in i.children : {
          attribute_name   = try(j.attribute_name, local.defaults.ise.device_administration.policy_sets.condition.attribute_name, null)
          attribute_value  = try(j.attribute_value, local.defaults.ise.device_administration.policy_sets.condition.attribute_value, null)
          dictionary_name  = try(j.dictionary_name, local.defaults.ise.device_administration.policy_sets.condition.dictionary_name, null)
          dictionary_value = try(j.dictionary_value, local.defaults.ise.device_administration.policy_sets.condition.dictionary_value, null)
          condition_type   = try(j.type, local.defaults.ise.device_administration.policy_sets.condition.type, null)
          is_negate        = try(j.is_negate, local.defaults.ise.device_administration.policy_sets.condition.is_negate, null)
          operator         = try(j.operator, local.defaults.ise.device_administration.policy_sets.condition.operator, null)
          id               = contains(local.known_conditions_device_admin, try(j.name, "")) ? ise_device_admin_condition.device_admin_condition[j.name].id : try(data.ise_device_admin_condition.device_admin_condition[j.name].id, null)
        }], null)
      }], null)
    }
  ]

  device_admin_policy_sets_with_ranks = [
    for idx, ps in local.device_admin_policy_sets : merge(ps, {
      generated_rank = idx
    })
  ]
}

resource "ise_device_admin_policy_set" "device_admin_policy_set" {
  for_each = { for ps in local.device_admin_policy_sets : ps.name => ps if ps.name != "Default" }

  condition_type            = each.value.condition_type
  condition_is_negate       = each.value.condition_is_negate
  condition_attribute_name  = each.value.condition_attribute_name
  condition_attribute_value = each.value.condition_attribute_value
  condition_dictionary_name = each.value.condition_dictionary_name
  condition_id              = each.value.condition_id
  condition_operator        = each.value.condition_operator
  description               = each.value.description
  is_proxy                  = each.value.is_proxy
  name                      = each.value.name
  service_name              = each.value.service_name
  state                     = each.value.state
  default                   = each.value.default
  children                  = each.value.children

  depends_on = [ise_allowed_protocols_tacacs.allowed_protocols_tacacs, ise_network_device_group.network_device_group_5, ise_active_directory_add_groups.active_directory_groups]
}

resource "ise_device_admin_policy_set" "default_device_admin_policy_set" {
  for_each = { for ps in local.device_admin_policy_sets : ps.name => ps if ps.name == "Default" }

  is_proxy     = each.value.is_proxy
  name         = each.value.name
  service_name = each.value.service_name
  state        = each.value.state
  default      = true

  depends_on = [ise_device_admin_policy_set.device_admin_policy_set]
}

resource "ise_device_admin_policy_set_update_rank" "device_admin_policy_set_update_rank" {
  for_each = { for ps in local.device_admin_policy_sets_with_ranks : ps.name => ps if ps.name != "Default" }

  policy_set_id = ise_device_admin_policy_set.device_admin_policy_set[each.key].id
  rank          = each.value.generated_rank
}

locals {
  device_admin_policy_set_ids = merge(
    { for ps in local.device_admin_policy_sets : ps.name => ise_device_admin_policy_set.device_admin_policy_set[ps.name].id if ps.name != "Default" },
    { for ps in local.device_admin_policy_sets : ps.name => ise_device_admin_policy_set.default_device_admin_policy_set[ps.name].id if ps.name == "Default" }
  )


  device_admin_authentication_rules = flatten([
    for ps in try(local.ise.device_administration.policy_sets, []) : [
      for generated_rank, rule in try(ps.authentication_rules, []) : {
        key                        = format("%s/%s", ps.name, rule.name)
        policy_set_id              = local.device_admin_policy_set_ids[ps.name]
        name                       = rule.name
        rank                       = try(rule.rank, local.defaults.ise.device_administration.policy_sets.authentication_rules.rank, null)
        generated_rank             = generated_rank
        default                    = rule.name == "Default" ? true : false
        state                      = try(rule.state, local.defaults.ise.device_administration.policy_sets.authentication_rules.state, null)
        condition_type             = rule.name == "Default" ? null : try(rule.condition.type, local.defaults.ise.device_administration.policy_sets.authentication_rules.condition.type, null)
        condition_id               = contains(local.known_conditions_device_admin, try(rule.condition.name, "")) ? ise_device_admin_condition.device_admin_condition[rule.condition.name].id : try(data.ise_device_admin_condition.device_admin_condition[rule.condition.name].id, null)
        condition_is_negate        = rule.name == "Default" ? null : try(rule.condition.is_negate, local.defaults.ise.device_administration.policy_sets.authentication_rules.condition.is_negate, null)
        condition_attribute_name   = rule.name == "Default" ? null : try(rule.condition.attribute_name, local.defaults.ise.device_administration.policy_sets.authentication_rules.condition.attribute_name, null)
        condition_attribute_value  = rule.name == "Default" ? null : try(rule.condition.attribute_value, local.defaults.ise.device_administration.policy_sets.authentication_rules.condition.attribute_value, null)
        condition_dictionary_name  = rule.name == "Default" ? null : try(rule.condition.dictionary_name, local.defaults.ise.device_administration.policy_sets.authentication_rules.condition.dictionary_name, null)
        condition_dictionary_value = rule.name == "Default" ? null : try(rule.condition.dictionary_value, local.defaults.ise.device_administration.policy_sets.authentication_rules.condition.dictionary_value, null)
        condition_operator         = rule.name == "Default" ? null : try(rule.condition.operator, local.defaults.ise.device_administration.policy_sets.authentication_rules.condition.operator, null)
        identity_source_name       = try(rule.identity_source_name, local.defaults.ise.device_administration.policy_sets.authentication_rules.identity_source_name, null)
        if_auth_fail               = try(rule.if_auth_fail, local.defaults.ise.device_administration.policy_sets.authentication_rules.if_auth_fail, null)
        if_process_fail            = try(rule.if_process_fail, local.defaults.ise.device_administration.policy_sets.authentication_rules.if_process_fail, null)
        if_user_not_found          = try(rule.if_user_not_found, local.defaults.ise.device_administration.policy_sets.authentication_rules.if_user_not_found, null)
        children = try([for i in rule.condition.children : {
          attribute_name   = try(i.attribute_name, local.defaults.ise.device_administration.policy_sets.authentication_rules.condition.attribute_name, null)
          attribute_value  = try(i.attribute_value, local.defaults.ise.device_administration.policy_sets.authentication_rules.condition.attribute_value, null)
          dictionary_name  = try(i.dictionary_name, local.defaults.ise.device_administration.policy_sets.authentication_rules.condition.dictionary_name, null)
          dictionary_value = try(i.dictionary_value, local.defaults.ise.device_administration.policy_sets.authentication_rules.condition.dictionary_value, null)
          condition_type   = try(i.type, local.defaults.ise.device_administration.policy_sets.authentication_rules.condition.type, null)
          is_negate        = try(i.is_negate, local.defaults.ise.device_administration.policy_sets.authentication_rules.condition.is_negate, null)
          operator         = try(i.operator, local.defaults.ise.device_administration.policy_sets.authentication_rules.condition.operator, null)
          id               = contains(local.known_conditions_device_admin, try(i.name, "")) ? ise_device_admin_condition.device_admin_condition[i.name].id : try(data.ise_device_admin_condition.device_admin_condition[i.name].id, null)
          children = try([for j in i.children : {
            attribute_name   = try(j.attribute_name, local.defaults.ise.device_administration.policy_sets.authentication_rules.condition.attribute_name, null)
            attribute_value  = try(j.attribute_value, local.defaults.ise.device_administration.policy_sets.authentication_rules.condition.attribute_value, null)
            dictionary_name  = try(j.dictionary_name, local.defaults.ise.device_administration.policy_sets.authentication_rules.condition.dictionary_name, null)
            dictionary_value = try(j.dictionary_value, local.defaults.ise.device_administration.policy_sets.authentication_rules.condition.dictionary_value, null)
            condition_type   = try(j.type, local.defaults.ise.device_administration.policy_sets.authentication_rules.condition.type, null)
            is_negate        = try(j.is_negate, local.defaults.ise.device_administration.policy_sets.authentication_rules.condition.is_negate, null)
            operator         = try(j.operator, local.defaults.ise.device_administration.policy_sets.authentication_rules.condition.operator, null)
            id               = contains(local.known_conditions_device_admin, try(j.name, "")) ? ise_device_admin_condition.device_admin_condition[j.name].id : try(data.ise_device_admin_condition.device_admin_condition[j.name].id, null)
          }], null)
        }], null)
      }
    ]
  ])

}

resource "ise_device_admin_authentication_rule" "device_admin_authentication_rule" {
  for_each = { for rule in local.device_admin_authentication_rules : rule.key => rule if rule.name != "Default" }

  policy_set_id             = each.value.policy_set_id
  name                      = each.value.name
  default                   = each.value.default
  state                     = each.value.state
  condition_type            = each.value.condition_type
  condition_id              = each.value.condition_id
  condition_is_negate       = each.value.condition_is_negate
  condition_attribute_name  = each.value.condition_attribute_name
  condition_attribute_value = each.value.condition_attribute_value
  condition_dictionary_name = each.value.condition_dictionary_name
  condition_operator        = each.value.condition_operator
  identity_source_name      = each.value.identity_source_name
  if_auth_fail              = each.value.if_auth_fail
  if_process_fail           = each.value.if_process_fail
  if_user_not_found         = each.value.if_user_not_found
  children                  = each.value.children

  depends_on = [ise_network_device_group.network_device_group_5, ise_active_directory_add_groups.active_directory_groups]
}

resource "ise_device_admin_authentication_rule" "default_device_admin_authentication_rule" {
  for_each = { for rule in local.device_admin_authentication_rules : rule.key => rule if rule.name == "Default" }

  name                 = each.value.name
  state                = each.value.state
  policy_set_id        = each.value.policy_set_id
  default              = true
  identity_source_name = each.value.identity_source_name
  if_auth_fail         = each.value.if_auth_fail
  if_process_fail      = each.value.if_process_fail
  if_user_not_found    = each.value.if_user_not_found

  depends_on = [ise_device_admin_authentication_rule.device_admin_authentication_rule]
}

resource "ise_device_admin_authentication_rule_update_rank" "device_admin_authentication_rule_update_rank" {
  for_each = { for rule in local.device_admin_authentication_rules : rule.key => rule if rule.name != "Default" }

  policy_set_id = each.value.policy_set_id
  rule_id       = ise_device_admin_authentication_rule.device_admin_authentication_rule[each.value.key].id
  rank          = each.value.generated_rank
}

# Workaround for ISE API issue where deleting a TACACS profile or command set immediately after deleting an object using it fails
resource "time_sleep" "device_admin_policy_object_wait" {
  count = (length(try(local.ise.device_administration.policy_elements.tacacs_profiles, [])) > 0 || length(try(local.ise.device_administration.policy_elements.tacacs_command_sets, [])) > 0) ? 1 : 0

  destroy_duration = "10s"

  depends_on = [
    ise_tacacs_profile.tacacs_profile,
    ise_tacacs_command_set.tacacs_command_set,
  ]
}

locals {
  device_admin_authorization_rules = flatten([
    for ps in try(local.ise.device_administration.policy_sets, []) : [
      for generated_rank, rule in try(ps.authorization_rules, []) : {
        key                        = format("%s/%s", ps.name, rule.name)
        policy_set_id              = local.device_admin_policy_set_ids[ps.name]
        name                       = rule.name
        rank                       = try(rule.rank, local.defaults.ise.device_administration.policy_sets.authorization_rules.rank, null)
        generated_rank             = generated_rank
        default                    = rule.name == "Default" ? true : false
        state                      = try(rule.state, local.defaults.ise.device_administration.policy_sets.authorization_rules.state, null)
        condition_type             = rule.name == "Default" ? null : try(rule.condition.type, local.defaults.ise.device_administration.policy_sets.authorization_rules.condition.type, null)
        condition_id               = contains(local.known_conditions_device_admin, try(rule.condition.name, "")) ? ise_device_admin_condition.device_admin_condition[rule.condition.name].id : try(data.ise_device_admin_condition.device_admin_condition[rule.condition.name].id, null)
        condition_is_negate        = rule.name == "Default" ? null : try(rule.condition.is_negate, local.defaults.ise.device_administration.policy_sets.authorization_rules.condition.is_negate, null)
        condition_attribute_name   = rule.name == "Default" ? null : try(rule.condition.attribute_name, local.defaults.ise.device_administration.policy_sets.authorization_rules.condition.attribute_name, null)
        condition_attribute_value  = rule.name == "Default" ? null : try(rule.condition.attribute_value, local.defaults.ise.device_administration.policy_sets.authorization_rules.condition.attribute_value, null)
        condition_dictionary_name  = rule.name == "Default" ? null : try(rule.condition.dictionary_name, local.defaults.ise.device_administration.policy_sets.authorization_rules.condition.dictionary_name, null)
        condition_dictionary_value = rule.name == "Default" ? null : try(rule.condition.dictionary_value, local.defaults.ise.device_administration.policy_sets.authorization_rules.condition.dictionary_value, null)
        condition_operator         = rule.name == "Default" ? null : try(rule.condition.operator, local.defaults.ise.device_administration.policy_sets.authorization_rules.condition.operator, null)
        profile                    = try(rule.profile, local.defaults.ise.device_administration.policy_sets.authorization_rules.profile, null)
        command_sets               = try(rule.command_sets, local.defaults.ise.device_administration.policy_sets.authorization_rules.command_sets, null)
        children = try([for i in rule.condition.children : {
          attribute_name   = try(i.attribute_name, local.defaults.ise.device_administration.policy_sets.authorization_rules.condition.attribute_name, null)
          attribute_value  = try(i.attribute_value, local.defaults.ise.device_administration.policy_sets.authorization_rules.condition.attribute_value, null)
          dictionary_name  = try(i.dictionary_name, local.defaults.ise.device_administration.policy_sets.authorization_rules.condition.dictionary_name, null)
          dictionary_value = try(i.dictionary_value, local.defaults.ise.device_administration.policy_sets.authorization_rules.condition.dictionary_value, null)
          condition_type   = try(i.type, local.defaults.ise.device_administration.policy_sets.authorization_rules.condition.type, null)
          is_negate        = try(i.is_negate, local.defaults.ise.device_administration.policy_sets.authorization_rules.condition.is_negate, null)
          operator         = try(i.operator, local.defaults.ise.device_administration.policy_sets.authorization_rules.condition.operator, null)
          id               = contains(local.known_conditions_device_admin, try(i.name, "")) ? ise_device_admin_condition.device_admin_condition[i.name].id : try(data.ise_device_admin_condition.device_admin_condition[i.name].id, null)
          children = try([for j in i.children : {
            attribute_name   = try(j.attribute_name, local.defaults.ise.device_administration.policy_sets.authorization_rules.condition.attribute_name, null)
            attribute_value  = try(j.attribute_value, local.defaults.ise.device_administration.policy_sets.authorization_rules.condition.attribute_value, null)
            dictionary_name  = try(j.dictionary_name, local.defaults.ise.device_administration.policy_sets.authorization_rules.condition.dictionary_name, null)
            dictionary_value = try(j.dictionary_value, local.defaults.ise.device_administration.policy_sets.authorization_rules.condition.dictionary_value, null)
            condition_type   = try(j.type, local.defaults.ise.device_administration.policy_sets.authorization_rules.condition.type, null)
            is_negate        = try(j.is_negate, local.defaults.ise.device_administration.policy_sets.authorization_rules.condition.is_negate, null)
            operator         = try(j.operator, local.defaults.ise.device_administration.policy_sets.authorization_rules.condition.operator, null)
            id               = contains(local.known_conditions_device_admin, try(j.name, "")) ? ise_device_admin_condition.device_admin_condition[j.name].id : try(data.ise_device_admin_condition.device_admin_condition[j.name].id, null)
          }], null)
        }], null)
      }
    ]
  ])

}

resource "ise_device_admin_authorization_rule" "device_admin_authorization_rule" {
  for_each = { for rule in local.device_admin_authorization_rules : rule.key => rule if rule.name != "Default" }

  policy_set_id             = each.value.policy_set_id
  name                      = each.value.name
  default                   = each.value.default
  state                     = each.value.state
  condition_type            = each.value.condition_type
  condition_id              = each.value.condition_id
  condition_is_negate       = each.value.condition_is_negate
  condition_attribute_name  = each.value.condition_attribute_name
  condition_attribute_value = each.value.condition_attribute_value
  condition_dictionary_name = each.value.condition_dictionary_name
  condition_operator        = each.value.condition_operator
  profile                   = each.value.profile
  command_sets              = each.value.command_sets
  children                  = each.value.children

  depends_on = [ise_tacacs_profile.tacacs_profile, ise_tacacs_command_set.tacacs_command_set, time_sleep.device_admin_policy_object_wait, ise_network_device_group.network_device_group_5, ise_active_directory_add_groups.active_directory_groups]
}

resource "ise_device_admin_authorization_rule" "default_device_admin_authorization_rule" {
  for_each = { for rule in local.device_admin_authorization_rules : rule.key => rule if rule.name == "Default" }

  name          = each.value.name
  state         = each.value.state
  policy_set_id = each.value.policy_set_id
  default       = true
  profile       = each.value.profile
  command_sets  = each.value.command_sets

  depends_on = [ise_device_admin_authorization_rule.device_admin_authorization_rule]
}

resource "ise_device_admin_authorization_rule_update_rank" "device_admin_authorization_rule_update_rank" {
  for_each = { for rule in local.device_admin_authorization_rules : rule.key => rule if rule.name != "Default" }

  policy_set_id = each.value.policy_set_id
  rule_id       = ise_device_admin_authorization_rule.device_admin_authorization_rule[each.value.key].id
  rank          = each.value.generated_rank
}

locals {
  device_admin_authorization_exception_rules = flatten([
    for ps in try(local.ise.device_administration.policy_sets, []) : [
      for generated_rank, rule in try(ps.authorization_exception_rules, []) : {
        key                        = format("%s/%s", ps.name, rule.name)
        policy_set_id              = local.device_admin_policy_set_ids[ps.name]
        name                       = rule.name
        rank                       = try(rule.rank, local.defaults.ise.device_administration.policy_sets.authorization_exception_rules.rank, null)
        generated_rank             = generated_rank
        state                      = try(rule.state, local.defaults.ise.device_administration.policy_sets.authorization_exception_rules.state, null)
        condition_type             = try(rule.condition.type, local.defaults.ise.device_administration.policy_sets.authorization_exception_rules.condition.type, null)
        condition_id               = contains(local.known_conditions_device_admin, try(rule.condition.name, "")) ? ise_device_admin_condition.device_admin_condition[rule.condition.name].id : try(data.ise_device_admin_condition.device_admin_condition[rule.condition.name].id, null)
        condition_is_negate        = try(rule.condition.is_negate, local.defaults.ise.device_administration.policy_sets.authorization_exception_rules.condition.is_negate, null)
        condition_attribute_name   = try(rule.condition.attribute_name, local.defaults.ise.device_administration.policy_sets.authorization_exception_rules.condition.attribute_name, null)
        condition_attribute_value  = try(rule.condition.attribute_value, local.defaults.ise.device_administration.policy_sets.authorization_exception_rules.condition.attribute_value, null)
        condition_dictionary_name  = try(rule.condition.dictionary_name, local.defaults.ise.device_administration.policy_sets.authorization_exception_rules.condition.dictionary_name, null)
        condition_dictionary_value = try(rule.condition.dictionary_value, local.defaults.ise.device_administration.policy_sets.authorization_exception_rules.condition.dictionary_value, null)
        condition_operator         = try(rule.condition.operator, local.defaults.ise.device_administration.policy_sets.authorization_exception_rules.condition.operator, null)
        profile                    = try(rule.profile, local.defaults.ise.device_administration.policy_sets.authorization_exception_rules.profile, null)
        command_sets               = try(rule.command_sets, local.defaults.ise.device_administration.policy_sets.authorization_exception_rules.command_sets, null)
        children = try([for i in rule.condition.children : {
          attribute_name   = try(i.attribute_name, local.defaults.ise.device_administration.policy_sets.authorization_exception_rules.condition.attribute_name, null)
          attribute_value  = try(i.attribute_value, local.defaults.ise.device_administration.policy_sets.authorization_exception_rules.condition.attribute_value, null)
          dictionary_name  = try(i.dictionary_name, local.defaults.ise.device_administration.policy_sets.authorization_exception_rules.condition.dictionary_name, null)
          dictionary_value = try(i.dictionary_value, local.defaults.ise.device_administration.policy_sets.authorization_exception_rules.condition.dictionary_value, null)
          condition_type   = try(i.type, local.defaults.ise.device_administration.policy_sets.authorization_exception_rules.condition.type, null)
          is_negate        = try(i.is_negate, local.defaults.ise.device_administration.policy_sets.authorization_exception_rules.condition.is_negate, null)
          operator         = try(i.operator, local.defaults.ise.device_administration.policy_sets.authorization_exception_rules.condition.operator, null)
          id               = contains(local.known_conditions_device_admin, try(i.name, "")) ? ise_device_admin_condition.device_admin_condition[i.name].id : try(data.ise_device_admin_condition.device_admin_condition[i.name].id, null)
          children = try([for j in i.children : {
            attribute_name   = try(j.attribute_name, local.defaults.ise.device_administration.policy_sets.authorization_exception_rules.condition.attribute_name, null)
            attribute_value  = try(j.attribute_value, local.defaults.ise.device_administration.policy_sets.authorization_exception_rules.condition.attribute_value, null)
            dictionary_name  = try(j.dictionary_name, local.defaults.ise.device_administration.policy_sets.authorization_exception_rules.condition.dictionary_name, null)
            dictionary_value = try(j.dictionary_value, local.defaults.ise.device_administration.policy_sets.authorization_exception_rules.condition.dictionary_value, null)
            condition_type   = try(j.type, local.defaults.ise.device_administration.policy_sets.authorization_exception_rules.condition.type, null)
            is_negate        = try(j.is_negate, local.defaults.ise.device_administration.policy_sets.authorization_exception_rules.condition.is_negate, null)
            operator         = try(j.operator, local.defaults.ise.device_administration.policy_sets.authorization_exception_rules.condition.operator, null)
            id               = contains(local.known_conditions_device_admin, try(j.name, "")) ? ise_device_admin_condition.device_admin_condition[j.name].id : try(data.ise_device_admin_condition.device_admin_condition[j.name].id, null)
          }], null)
        }], null)
      }
    ]
  ])

}

resource "ise_device_admin_authorization_exception_rule" "device_admin_authorization_exception_rule" {
  for_each = { for rule in local.device_admin_authorization_exception_rules : rule.key => rule }

  policy_set_id             = each.value.policy_set_id
  name                      = each.value.name
  state                     = each.value.state
  condition_type            = each.value.condition_type
  condition_id              = each.value.condition_id
  condition_is_negate       = each.value.condition_is_negate
  condition_attribute_name  = each.value.condition_attribute_name
  condition_attribute_value = each.value.condition_attribute_value
  condition_dictionary_name = each.value.condition_dictionary_name
  condition_operator        = each.value.condition_operator
  profile                   = each.value.profile
  command_sets              = each.value.command_sets
  children                  = each.value.children

  depends_on = [ise_tacacs_profile.tacacs_profile, ise_tacacs_command_set.tacacs_command_set, time_sleep.device_admin_policy_object_wait, ise_network_device_group.network_device_group_5, ise_active_directory_add_groups.active_directory_groups]
}

resource "ise_device_admin_authorization_exception_rule_update_rank" "device_admin_authorization_exception_rule_update_rank" {
  for_each = { for rule in local.device_admin_authorization_exception_rules : rule.key => rule }

  policy_set_id = each.value.policy_set_id
  rule_id       = ise_device_admin_authorization_exception_rule.device_admin_authorization_exception_rule[each.value.key].id
  rank          = each.value.generated_rank
}

locals {
  device_admin_authorization_global_exception_rules = [
    for rule in try(local.ise.device_administration.authorization_global_exception_rules, []) : {
      name                       = rule.name
      rank                       = try(rule.rank, local.defaults.ise.device_administration.authorization_global_exception_rules.rank, null)
      state                      = try(rule.state, local.defaults.ise.device_administration.authorization_global_exception_rules.state, null)
      condition_type             = try(rule.condition.type, local.defaults.ise.device_administration.authorization_global_exception_rules.condition.type, null)
      condition_id               = contains(local.known_conditions_device_admin, try(rule.condition.name, "")) ? ise_device_admin_condition.device_admin_condition[rule.condition.name].id : try(data.ise_device_admin_condition.device_admin_condition[rule.condition.name].id, null)
      condition_is_negate        = try(rule.condition.is_negate, local.defaults.ise.device_administration.authorization_global_exception_rules.condition.is_negate, null)
      condition_attribute_name   = try(rule.condition.attribute_name, local.defaults.ise.device_administration.authorization_global_exception_rules.condition.attribute_name, null)
      condition_attribute_value  = try(rule.condition.attribute_value, local.defaults.ise.device_administration.authorization_global_exception_rules.condition.attribute_value, null)
      condition_dictionary_name  = try(rule.condition.dictionary_name, local.defaults.ise.device_administration.authorization_global_exception_rules.condition.dictionary_name, null)
      condition_dictionary_value = try(rule.condition.dictionary_value, local.defaults.ise.device_administration.authorization_global_exception_rules.condition.dictionary_value, null)
      condition_operator         = try(rule.condition.operator, local.defaults.ise.device_administration.authorization_global_exception_rules.condition.operator, null)
      profile                    = try(rule.profile, local.defaults.ise.device_administration.authorization_global_exception_rules.profile, null)
      command_sets               = try(rule.command_sets, local.defaults.ise.device_administration.authorization_global_exception_rules.command_sets, null)
      children = try([for i in rule.condition.children : {
        attribute_name   = try(i.attribute_name, local.defaults.ise.device_administration.authorization_global_exception_rules.condition.attribute_name, null)
        attribute_value  = try(i.attribute_value, local.defaults.ise.device_administration.authorization_global_exception_rules.condition.attribute_value, null)
        dictionary_name  = try(i.dictionary_name, local.defaults.ise.device_administration.authorization_global_exception_rules.condition.dictionary_name, null)
        dictionary_value = try(i.dictionary_value, local.defaults.ise.device_administration.authorization_global_exception_rules.condition.dictionary_value, null)
        condition_type   = try(i.type, local.defaults.ise.device_administration.authorization_global_exception_rules.condition.type, null)
        is_negate        = try(i.is_negate, local.defaults.ise.device_administration.authorization_global_exception_rules.condition.is_negate, null)
        operator         = try(i.operator, local.defaults.ise.device_administration.authorization_global_exception_rules.condition.operator, null)
        id               = contains(local.known_conditions_device_admin, try(i.name, "")) ? ise_device_admin_condition.device_admin_condition[i.name].id : try(data.ise_device_admin_condition.device_admin_condition[i.name].id, null)
        children = try([for j in i.children : {
          attribute_name   = try(j.attribute_name, local.defaults.ise.device_administration.authorization_global_exception_rules.condition.attribute_name, null)
          attribute_value  = try(j.attribute_value, local.defaults.ise.device_administration.authorization_global_exception_rules.condition.attribute_value, null)
          dictionary_name  = try(j.dictionary_name, local.defaults.ise.device_administration.authorization_global_exception_rules.condition.dictionary_name, null)
          dictionary_value = try(j.dictionary_value, local.defaults.ise.device_administration.authorization_global_exception_rules.condition.dictionary_value, null)
          condition_type   = try(j.type, local.defaults.ise.device_administration.authorization_global_exception_rules.condition.type, null)
          is_negate        = try(j.is_negate, local.defaults.ise.device_administration.authorization_global_exception_rules.condition.is_negate, null)
          operator         = try(j.operator, local.defaults.ise.device_administration.authorization_global_exception_rules.condition.operator, null)
          id               = contains(local.known_conditions_device_admin, try(j.name, "")) ? ise_device_admin_condition.device_admin_condition[j.name].id : try(data.ise_device_admin_condition.device_admin_condition[j.name].id, null)
        }], null)
      }], null)
    }
  ]

  device_admin_authorization_global_exception_rules_with_ranks = [
    for idx, rule in local.device_admin_authorization_global_exception_rules : merge(rule, {
      generated_rank = idx
    })
  ]
}

resource "ise_device_admin_authorization_global_exception_rule" "device_admin_authorization_global_exception_rule" {
  for_each = { for rule in local.device_admin_authorization_global_exception_rules : rule.name => rule }

  name                      = each.value.name
  state                     = each.value.state
  condition_type            = each.value.condition_type
  condition_id              = each.value.condition_id
  condition_is_negate       = each.value.condition_is_negate
  condition_attribute_name  = each.value.condition_attribute_name
  condition_attribute_value = each.value.condition_attribute_value
  condition_dictionary_name = each.value.condition_dictionary_name
  condition_operator        = each.value.condition_operator
  profile                   = each.value.profile
  command_sets              = each.value.command_sets
  children                  = each.value.children

  depends_on = [ise_tacacs_profile.tacacs_profile, ise_tacacs_command_set.tacacs_command_set, time_sleep.device_admin_policy_object_wait, ise_network_device_group.network_device_group_5, ise_active_directory_add_groups.active_directory_groups]
}

resource "ise_device_admin_authorization_global_exception_rule_update_rank" "device_admin_authorization_global_exception_rule_update_rank" {
  for_each = { for rule in local.device_admin_authorization_global_exception_rules_with_ranks : rule.name => rule }

  rule_id = ise_device_admin_authorization_global_exception_rule.device_admin_authorization_global_exception_rule[each.value.name].id
  rank    = each.value.generated_rank
}
