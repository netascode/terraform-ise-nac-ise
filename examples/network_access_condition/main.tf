module "ise" {
  source  = "netascode/nac-ise/ise"
  version = ">= 0.2.0"

  yaml_files = ["network_access_condition.yaml"]
}
