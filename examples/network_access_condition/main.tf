module "ise" {
  source  = "netascode/nac-ise/ise"
  version = "1.0.0"

  yaml_files = ["network_access_condition.yaml"]
}
