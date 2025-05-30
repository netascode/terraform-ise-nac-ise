terraform {
  required_version = ">= 1.8.0"

  required_providers {
    ise = {
      source  = "CiscoDevNet/ise"
      version = ">= 0.2.7"
    }
    utils = {
      source  = "netascode/utils"
      version = ">= 1.0.0"
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
