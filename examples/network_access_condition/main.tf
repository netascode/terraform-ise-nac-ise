module "ise" {
  source  = "netascode/nac-ise/ise"
  version = ">= 0.1.0"

  yaml_files = ["network_access_condition.yaml"]

  manage_network_access = true
}
