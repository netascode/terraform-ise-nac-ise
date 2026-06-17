terraform {
  required_version = ">= 1.8.0"

  required_providers {
    ise = {
      source  = "CiscoDevNet/ise"
      version = "~> 0.3.3"
    }
    utils = {
      source  = "netascode/utils"
      version = "2.0.0-beta2"
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
