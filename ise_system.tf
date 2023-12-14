resource "ise_repository" "repository" {
  for_each = { for repository in try(local.ise.system.repositories, []) : repository.name => repository if var.manage_system }

  name        = each.key
  enable_pki  = try(each.value.enable_pki, local.defaults.ise.system.repositories.enable_pki, null)
  password    = try(each.value.password, local.defaults.ise.system.repositories.password, null)
  path        = try(each.value.path, local.defaults.ise.system.repositories.path, null)
  protocol    = try(each.value.protocol, local.defaults.ise.system.repositories.protocol, null)
  server_name = try(each.value.server_name, local.defaults.ise.system.repositories.server_name, null)
  user_name   = try(each.value.user_name, local.defaults.ise.system.repositories.user_name, null)
}

resource "ise_license_tier_state" "license_tier_state" {
  count = length(try(local.ise.system.licenses, [])) > 0 && var.manage_system ? 1 : 0

  licenses = [for license in try(local.ise.system.licenses, []) : {
    name   = license.name
    status = try(license.status, local.defaults.ise.system.licenses.status, null)
  }]
}
