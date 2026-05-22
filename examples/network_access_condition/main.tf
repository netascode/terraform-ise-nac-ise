module "ise" {
  source  = "netascode/nac-ise/ise"
  version = "0.3.0"

  yaml_files = ["network_access_condition.yaml"]
}
