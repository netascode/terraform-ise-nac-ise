variable "yaml_directories" {
  description = "List of paths to YAML directories."
  type        = list(string)
  default     = []
}

variable "yaml_files" {
  description = "List of paths to YAML files."
  type        = list(string)
  default     = []
}

variable "model" {
  description = "As an alternative to YAML files, a native Terraform data structure can be provided as well."
  type        = map(any)
  default     = {}
}

variable "manage_network_resources" {
  description = "Flag to indicate if network resources configuration should be managed."
  type        = bool
  default     = false
}

variable "manage_network_access" {
  description = "Flag to indicate if network access configuration should be managed."
  type        = bool
  default     = false
}

variable "manage_device_administration" {
  description = "Flag to indicate if device administration configuration should be managed."
  type        = bool
  default     = false
}

variable "manage_identity_management" {
  description = "Flag to indicate if identity management configuration should be managed."
  type        = bool
  default     = false
}

variable "manage_trust_sec" {
  description = "Flag to indicate if TrustSec configuration should be managed."
  type        = bool
  default     = false
}

variable "manage_system" {
  description = "Flag to indicate if system configuration should be managed."
  type        = bool
  default     = false
}

variable "write_default_values_file" {
  description = "Write all default values to a YAML file. Value is a path pointing to the file to be created."
  type        = string
  default     = ""
}
