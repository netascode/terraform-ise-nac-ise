locals {
  # Flatten matrix_entries from matrices[] list, or fall back to legacy flat matrix_entries
  trustsec_matrix_cells = length(try(local.ise.trust_sec.matrices, [])) > 0 ? flatten([
    for matrix in local.ise.trust_sec.matrices : [
      for cell in try(matrix.matrix_entries, []) : merge(cell, { matrix_name = matrix.name })
    ]
    ]) : [
    for cell in try(local.ise.trust_sec.matrix_entries, []) : merge(cell, { matrix_name = "Production" })
  ]
  trustsec_matrix = { for cell in local.trustsec_matrix_cells : "${cell.matrix_name}-${cell.source_sgt}-${cell.destination_sgt}" => cell }

  unique_sgts    = distinct(concat([for key, value in local.trustsec_matrix : value.source_sgt], [for key, value in local.trustsec_matrix : value.destination_sgt], [for map in try(local.ise.trust_sec.ip_sgt_mappings, []) : try(map.sgt, null) if try(map.sgt, null) != null], [for map in try(local.ise.trust_sec.ip_sgt_mapping_groups, []) : try(map.sgt, null) if try(map.sgt, null) != null]))
  known_sgts     = [for group in try(local.ise.trust_sec.security_groups, []) : group.name]
  unknown_sgts   = setsubtract(local.unique_sgts, local.known_sgts)
  unique_sgacls  = distinct([for key, value in local.trustsec_matrix : value.sgacl_name])
  known_sgacls   = [for acl in try(local.ise.trust_sec.security_group_acls, []) : acl.name]
  unknown_sgacls = setsubtract(local.unique_sgacls, local.known_sgacls)

  # MULTIPLE_MATRICES mode: create each named matrix except "Production" (always built-in in ISE); SINGLE_MATRIX mode: no matrix resources needed
  trustsec_matrices_to_create = {
    for matrix in try(local.ise.trust_sec.matrices, []) : matrix.name => matrix
    if matrix.name != "Production" && try(local.ise.trust_sec.matrix_mode, "SINGLE_MATRIX") == "MULTIPLE_MATRICES"
  }

  # Matrices that are not "Production" and not being created by us (need data source lookup)
  # Also includes any matrix name referenced in copy_policy_from
  unknown_matrices = toset(concat(
    [
      for cell in local.trustsec_matrix_cells : cell.matrix_name
      if cell.matrix_name != "Production" && !contains(keys(local.trustsec_matrices_to_create), cell.matrix_name)
    ],
    [
      for matrix in try(local.ise.trust_sec.matrices, []) : matrix.copy_policy_from
      if try(matrix.copy_policy_from, null) != null
    ]
  ))
}

data "ise_trustsec_security_group" "trustsec_security_group" {
  for_each = toset(local.unknown_sgts)

  name = each.value
}

data "ise_trustsec_security_group_acl" "trustsec_security_group_acl" {
  for_each = toset(local.unknown_sgacls)

  name = each.value
}

data "ise_trustsec_matrix" "trustsec_matrix" {
  for_each = local.unknown_matrices

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

locals {
  # Network Device Groups for IP-SGT mappings
  sgt_mappings_groups_network_device_groups = { for group in try(local.ise.trust_sec.ip_sgt_mapping_groups, []) : group.name => try(group.deploy_to, null) if try(group.deploy_type, null) == "NDG" }
  sgt_mappings_network_device_groups        = { for mapping in try(local.ise.trust_sec.ip_sgt_mappings, []) : try(mapping.host_name, mapping.host_ip) => try(mapping.deploy_to, null) if try(mapping.deploy_type, null) == "NDG" && try(mapping.mapping_group, null) == null }
  unique_network_device_groups              = distinct(compact(concat([for key, value in local.sgt_mappings_groups_network_device_groups : value], [for key, value in local.sgt_mappings_network_device_groups : value])))
  known_network_device_groups               = [for group in try(local.all_network_device_groups, []) : group.name]
  unknown_network_device_groups             = setsubtract(local.unique_network_device_groups, local.known_network_device_groups)

  # Network Devices for IP-SGT mappings
  sgt_mappings_groups_network_devices = { for group in try(local.ise.trust_sec.ip_sgt_mapping_groups, []) : group.name => try(group.deploy_to, null) if try(group.deploy_type, null) == "ND" }
  sgt_mappings_network_devices        = { for mapping in try(local.ise.trust_sec.ip_sgt_mappings, []) : try(mapping.host_name, mapping.host_ip) => try(mapping.deploy_to, null) if try(mapping.deploy_type, null) == "ND" && try(mapping.mapping_group, null) == null }
  unique_network_devices              = distinct(compact(concat([for key, value in local.sgt_mappings_groups_network_devices : value], [for key, value in local.sgt_mappings_network_devices : value])))
  known_network_devices               = [for nd in try(local.ise.network_resources.network_devices, []) : nd.name]
  unknown_network_devices             = setsubtract(local.unique_network_devices, local.known_network_devices)
}

data "ise_network_device_group" "network_device_group" {
  for_each = toset(local.unknown_network_device_groups)

  name = each.value
}

data "ise_network_device" "network_device" {
  for_each = toset(local.unknown_network_devices)

  name = each.value
}

resource "ise_trustsec_ip_to_sgt_mapping_group" "trustsec_ip_to_sgt_mapping_group" {
  for_each = { for group in try(local.ise.trust_sec.ip_sgt_mapping_groups, []) : group.name => group }

  name        = each.key
  sgt         = contains(local.known_sgts, each.value.sgt) ? ise_trustsec_security_group.trustsec_security_group[each.value.sgt].id : data.ise_trustsec_security_group.trustsec_security_group[each.value.sgt].id
  deploy_type = try(each.value.deploy_type, local.defaults.ise.trust_sec.ip_sgt_mappings.deploy_type, null)
  deploy_to = try(each.value.deploy_type, local.defaults.ise.trust_sec.ip_sgt_mappings.deploy_type, null) == "ALL" ? null : (
    try(each.value.deploy_type, local.defaults.ise.trust_sec.ip_sgt_mappings.deploy_type, null) == "ND" ? (
      contains(local.known_network_devices, each.value.deploy_to) ? ise_network_device.network_device[each.value.deploy_to].id : data.ise_network_device.network_device[each.value.deploy_to].id
      ) : (
      contains(local.known_network_device_groups, each.value.deploy_to) ? try(ise_network_device_group.network_device_group_0[each.value.deploy_to].id, ise_network_device_group.network_device_group_1[each.value.deploy_to].id, ise_network_device_group.network_device_group_2[each.value.deploy_to].id, ise_network_device_group.network_device_group_3[each.value.deploy_to].id, ise_network_device_group.network_device_group_4[each.value.deploy_to].id, ise_network_device_group.network_device_group_5[each.value.deploy_to].id) : data.ise_network_device_group.network_device_group[each.value.deploy_to].id
    )
  )

  depends_on = [
    time_sleep.sgt_wait,
    ise_network_device.network_device,
    ise_network_device_group.network_device_group_0,
    ise_network_device_group.network_device_group_1,
    ise_network_device_group.network_device_group_2,
    ise_network_device_group.network_device_group_3,
    ise_network_device_group.network_device_group_4,
    ise_network_device_group.network_device_group_5,
  ]
}

resource "ise_trustsec_ip_to_sgt_mapping" "trustsec_ip_to_sgt_mapping" {
  for_each = { for map in try(local.ise.trust_sec.ip_sgt_mappings, []) : try(map.host_name, map.host_ip) => map }

  name          = each.key
  host_ip       = try(each.value.host_ip, local.defaults.ise.trust_sec.ip_sgt_mappings.host_ip, null)
  host_name     = try(each.value.host_name, local.defaults.ise.trust_sec.ip_sgt_mappings.host_name, null)
  sgt           = try(each.value.mapping_group, null) != null ? null : try(each.value.sgt, null) != null ? (contains(local.known_sgts, each.value.sgt) ? ise_trustsec_security_group.trustsec_security_group[each.value.sgt].id : data.ise_trustsec_security_group.trustsec_security_group[each.value.sgt].id) : null
  mapping_group = try(each.value.mapping_group, null) != null ? ise_trustsec_ip_to_sgt_mapping_group.trustsec_ip_to_sgt_mapping_group[each.value.mapping_group].id : null
  deploy_type   = try(each.value.mapping_group, null) != null ? null : try(each.value.deploy_type, local.defaults.ise.trust_sec.ip_sgt_mappings.deploy_type, null)
  deploy_to = try(each.value.mapping_group, null) != null ? null : (
    try(each.value.deploy_type, local.defaults.ise.trust_sec.ip_sgt_mappings.deploy_type, null) == "ALL" ? null : (
      try(each.value.deploy_type, local.defaults.ise.trust_sec.ip_sgt_mappings.deploy_type, null) == "ND" ? (
        contains(local.known_network_devices, each.value.deploy_to) ? ise_network_device.network_device[each.value.deploy_to].id : data.ise_network_device.network_device[each.value.deploy_to].id
        ) : (
        contains(local.known_network_device_groups, each.value.deploy_to) ? try(ise_network_device_group.network_device_group_0[each.value.deploy_to].id, ise_network_device_group.network_device_group_1[each.value.deploy_to].id, ise_network_device_group.network_device_group_2[each.value.deploy_to].id, ise_network_device_group.network_device_group_3[each.value.deploy_to].id, ise_network_device_group.network_device_group_4[each.value.deploy_to].id, ise_network_device_group.network_device_group_5[each.value.deploy_to].id) : data.ise_network_device_group.network_device_group[each.value.deploy_to].id
      )
    )
  )

  depends_on = [
    time_sleep.sgt_wait,
    ise_network_device.network_device,
    ise_network_device_group.network_device_group_0,
    ise_network_device_group.network_device_group_1,
    ise_network_device_group.network_device_group_2,
    ise_network_device_group.network_device_group_3,
    ise_network_device_group.network_device_group_4,
    ise_network_device_group.network_device_group_5,
  ]
}

# Workaround for ISE API issue where deleting an SGT immediately after deleting an object using this SGT fails
resource "time_sleep" "sgt_wait" {
  count = length(try(local.ise.trust_sec.security_groups, [])) > 0 ? 1 : 0

  destroy_duration = "10s"

  depends_on = [ise_trustsec_security_group.trustsec_security_group]
}

resource "ise_trustsec_work_process_settings" "trustsec_work_process_settings" {
  count = try(local.ise.trust_sec.matrix_mode, null) != null ? 1 : 0

  matrix_mode              = try(local.ise.trust_sec.matrix_mode, local.defaults.ise.trust_sec.matrix_mode, null)
  use_defcons              = try(local.ise.trust_sec.work_process_settings.use_defcons, local.defaults.ise.trust_sec.work_process_settings.use_defcons, null)
  enable_approval_workflow = try(local.ise.trust_sec.work_process_settings.enable_approval_workflow, local.defaults.ise.trust_sec.work_process_settings.enable_approval_workflow, null)
}

resource "ise_trustsec_matrix" "trustsec_matrix" {
  for_each = local.trustsec_matrices_to_create

  name               = each.key
  description        = try(each.value.description, local.defaults.ise.trust_sec.matrices.description, null)
  defcon_level       = try(each.value.defcon_level, null)
  matrix_policy_type = try(each.value.matrix_policy_type, local.defaults.ise.trust_sec.matrices.matrix_policy_type, null)
  copy_policy_from   = try(each.value.copy_policy_from, null) == null ? null : data.ise_trustsec_matrix.trustsec_matrix[each.value.copy_policy_from].id

  depends_on = [ise_trustsec_work_process_settings.trustsec_work_process_settings]
}

resource "ise_trustsec_egress_matrix_cell" "trustsec_egress_matrix_cell" {
  for_each = local.trustsec_matrix

  source_sgt_id      = contains(local.known_sgts, each.value.source_sgt) ? ise_trustsec_security_group.trustsec_security_group[each.value.source_sgt].id : data.ise_trustsec_security_group.trustsec_security_group[each.value.source_sgt].id
  destination_sgt_id = contains(local.known_sgts, each.value.destination_sgt) ? ise_trustsec_security_group.trustsec_security_group[each.value.destination_sgt].id : data.ise_trustsec_security_group.trustsec_security_group[each.value.destination_sgt].id
  matrix_cell_status = try(each.value.rule_status, local.defaults.ise.trust_sec.matrix_entries.rule_status, null)
  sgacls             = contains(local.known_sgacls, each.value.sgacl_name) ? [ise_trustsec_security_group_acl.trustsec_security_group_acl[each.value.sgacl_name].id] : try([data.ise_trustsec_security_group_acl.trustsec_security_group_acl[each.value.sgacl_name].id], [])
  matrix_id = each.value.matrix_name == "Production" ? null : (
    contains(keys(local.trustsec_matrices_to_create), each.value.matrix_name)
    ? ise_trustsec_matrix.trustsec_matrix[each.value.matrix_name].id
    : data.ise_trustsec_matrix.trustsec_matrix[each.value.matrix_name].id
  )

  lifecycle {
    ignore_changes = [default_rule]
  }

  depends_on = [
    time_sleep.sgt_wait,
    ise_trustsec_matrix.trustsec_matrix,
  ]
}

# Terraform data resource to track changes to TrustSec resources for automatic push
resource "terraform_data" "trustsec_resources_trigger" {
  count = try(local.ise.trust_sec.push_mode, local.defaults.ise.trust_sec.push_mode, "DISABLED") == "AUTO" ? 1 : 0

  triggers_replace = {
    security_groups     = md5(jsonencode(try(local.ise.trust_sec.security_groups, [])))
    security_group_acls = md5(jsonencode(try(local.ise.trust_sec.security_group_acls, [])))
    matrix_entries      = md5(jsonencode(try(local.ise.trust_sec.matrix_entries, [])))
    matrices            = md5(jsonencode(try(local.ise.trust_sec.matrices, [])))
  }
}

# DISABLED mode (default): TrustSec policy changes stay in ISE database only
# AUTO mode: Set push_mode: AUTO to automatically push when TrustSec resources change
# Pushes TrustSec Environment Data, SGACLs, and Policy Matrix to network devices
resource "ise_trustsec_egress_push_matrix" "push_auto" {
  count = try(local.ise.trust_sec.push_mode, local.defaults.ise.trust_sec.push_mode, "DISABLED") == "AUTO" ? 1 : 0

  lifecycle {
    replace_triggered_by = [
      terraform_data.trustsec_resources_trigger[0]
    ]
  }

  depends_on = [
    ise_trustsec_security_group.trustsec_security_group,
    ise_trustsec_security_group_acl.trustsec_security_group_acl,
    ise_trustsec_egress_matrix_cell.trustsec_egress_matrix_cell,
    ise_trustsec_matrix.trustsec_matrix,
  ]
}