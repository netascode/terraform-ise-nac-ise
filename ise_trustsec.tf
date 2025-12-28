locals {
  trustsec_matrix = { for cell in try(local.ise.trust_sec.matrix_entries, []) : "${cell.source_sgt}-${cell.destination_sgt}" => cell }
  unique_sgts     = distinct(concat([for key, value in local.trustsec_matrix : value.source_sgt], [for key, value in local.trustsec_matrix : value.destination_sgt], [for map in try(local.ise.trust_sec.ip_sgt_mappings, []) : try(map.sgt, null) if try(map.sgt, null) != null], [for map in try(local.ise.trust_sec.ip_sgt_mapping_groups, []) : try(map.sgt, null) if try(map.sgt, null) != null]))
  known_sgts      = [for group in try(local.ise.trust_sec.security_groups, []) : group.name]
  unknown_sgts    = setsubtract(local.unique_sgts, local.known_sgts)
  unique_sgacls   = distinct([for key, value in local.trustsec_matrix : value.sgacl_name])
  known_sgacls    = [for acl in try(local.ise.trust_sec.security_group_acls, []) : acl.name]
  unknown_sgacls  = setsubtract(local.unique_sgacls, local.known_sgacls)
}

data "ise_trustsec_security_group" "trustsec_security_group" {
  for_each = toset(local.unknown_sgts)

  name = each.value
}

data "ise_trustsec_security_group_acl" "trustsec_security_group_acl" {
  for_each = toset(local.unknown_sgacls)

  name = each.value
}

resource "ise_trustsec_security_group" "trustsec_security_group" {
  for_each = { for group in try(local.ise.trust_sec.security_groups, []) : group.name => group }

  name              = each.key
  description       = try(each.value.description, local.defaults.ise.trust_sec.security_groups.description, null)
  propogate_to_apic = try(each.value.propagate_to_apic, local.defaults.ise.trust_sec.security_groups.propogate_to_apic, null)
  value             = try(each.value.value, local.defaults.ise.trust_sec.security_groups.value, null)
}

resource "ise_trustsec_security_group_acl" "trustsec_security_group_acl" {
  for_each = { for acl in try(local.ise.trust_sec.security_group_acls, []) : acl.name => acl }

  name        = each.key
  acl_content = try(each.value.acl_content, local.defaults.ise.trust_sec.security_group_acls.acl_content, null)
  description = try(each.value.description, local.defaults.ise.trust_sec.security_group_acls.description, null)
  ip_version  = try(each.value.ip_version, local.defaults.ise.trust_sec.security_group_acls.ip_version, null)

  depends_on = [ise_trustsec_security_group.trustsec_security_group]
}

resource "ise_trustsec_ip_to_sgt_mapping_group" "trustsec_ip_to_sgt_mapping_group" {
  for_each = { for group in try(local.ise.trust_sec.ip_sgt_mapping_groups, []) : group.name => group }

  name        = each.key
  sgt         = contains(local.known_sgts, each.value.sgt) ? ise_trustsec_security_group.trustsec_security_group[each.value.sgt].id : data.ise_trustsec_security_group.trustsec_security_group[each.value.sgt].id
  deploy_type = try(each.value.deploy_type, local.defaults.ise.trust_sec.ip_sgt_mappings.deploy_type, null)
  deploy_to   = try(each.value.deploy_to, local.defaults.ise.trust_sec.ip_sgt_mappings.deploy_to, null)

  depends_on = [time_sleep.sgt_wait]
}

resource "ise_trustsec_ip_to_sgt_mapping" "trustsec_ip_to_sgt_mapping" {
  for_each = { for map in try(local.ise.trust_sec.ip_sgt_mappings, []) : try(map.host_name, map.host_ip) => map }

  name          = each.key
  host_ip       = try(each.value.host_ip, local.defaults.ise.trust_sec.ip_sgt_mappings.host_ip, null)
  host_name     = try(each.value.host_name, local.defaults.ise.trust_sec.ip_sgt_mappings.host_name, null)
  sgt           = try(each.value.mapping_group, null) != null ? null : try(each.value.sgt, null) != null ? (contains(local.known_sgts, each.value.sgt) ? ise_trustsec_security_group.trustsec_security_group[each.value.sgt].id : data.ise_trustsec_security_group.trustsec_security_group[each.value.sgt].id) : null
  mapping_group = try(each.value.mapping_group, null) != null ? ise_trustsec_ip_to_sgt_mapping_group.trustsec_ip_to_sgt_mapping_group[each.value.mapping_group].id : null
  deploy_type   = try(each.value.mapping_group, null) != null ? null : try(each.value.deploy_type, local.defaults.ise.trust_sec.ip_sgt_mappings.deploy_type, null)
  deploy_to     = try(each.value.mapping_group, null) != null ? null : try(each.value.deploy_to, local.defaults.ise.trust_sec.ip_sgt_mappings.deploy_to, null)

  depends_on = [time_sleep.sgt_wait]
}

# Workaround for ISE API issue where deleting an SGT immediately after deleting an object using this SGT fails
resource "time_sleep" "sgt_wait" {
  count = length(try(local.ise.trust_sec.security_groups, [])) > 0 ? 1 : 0

  destroy_duration = "10s"

  depends_on = [ise_trustsec_security_group.trustsec_security_group]
}

resource "ise_trustsec_egress_matrix_cell" "trustsec_egress_matrix_cell" {
  for_each = local.trustsec_matrix

  source_sgt_id      = contains(local.known_sgts, each.value.source_sgt) ? ise_trustsec_security_group.trustsec_security_group[each.value.source_sgt].id : data.ise_trustsec_security_group.trustsec_security_group[each.value.source_sgt].id
  destination_sgt_id = contains(local.known_sgts, each.value.destination_sgt) ? ise_trustsec_security_group.trustsec_security_group[each.value.destination_sgt].id : data.ise_trustsec_security_group.trustsec_security_group[each.value.destination_sgt].id
  matrix_cell_status = try(each.value.rule_status, local.defaults.ise.trust_sec.matrix_entries.rule_status, null)
  sgacls             = contains(local.known_sgacls, each.value.sgacl_name) ? [ise_trustsec_security_group_acl.trustsec_security_group_acl[each.value.sgacl_name].id] : try([data.ise_trustsec_security_group_acl.trustsec_security_group_acl[each.value.sgacl_name].id], [])

  lifecycle {
    ignore_changes = [default_rule]
  }

  depends_on = [time_sleep.sgt_wait]
}

resource "ise_trustsec_egress_push_matrix" "push_matrix" {
  force = try(local.ise.trust_sec.matrix_push, local.defaults.ise.trust_sec.matrix_push, false)

  depends_on = [
    ise_trustsec_egress_matrix_cell.trustsec_egress_matrix_cell
  ]
}