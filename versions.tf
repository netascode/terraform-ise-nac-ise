terraform {
  required_version = ">= 1.3.0"

  required_providers {
    ise = {
      source  = "CiscoDevNet/ise"
      version = ">= 0.1.8"
    }
    utils = {
      source  = "netascode/utils"
      version = ">= 0.2.5"
    }
    local = {
      source  = "hashicorp/local"
      version = ">= 2.3.0"
    }
    time = {
      source  = "hashicorp/time"
      version = ">= 0.10.0"
    }
  }
}
