## 0.2.3 (unreleased)

- Add support for optional Active Directory join operation with `join_domain` flag, allowing creation of join points and addition of groups without executing join
- Add support for automatic TrustSec policy push (SGTs, SGACLs, and egress matrix) to network devices with configurable `push_mode` (AUTO/DISABLED)
- Add support for shell profile av-pairs under authorization profiles

## 0.2.2

- Fix issue with incorrect merging of authorization rules [link](https://github.com/netascode/terraform-ise-nac-ise/issues/27)
- Fix issue with Cisco AV pairs not working properly within an authorization profile [link](https://github.com/netascode/terraform-ise-nac-ise/issues/28)

## 0.2.1

- Use Terraform functions to merge YAML content instead of data sources
- Fix issue with idepotency when assigning device to DNAC network device group

## 0.2.0

- BREAKING CHANGE: Replace `network_access_*_update_rank` and `device_admin_*_update_rank` resources with `network_access_*_update_ranks` and `device_admin_*_update_ranks` resources to support bulk updates of ranks across (Policy Sets, Authentication Rules, Authorization Rules, Authorization Global Exception Rules and Authorization Exception Rules) under Network Access and Device Administration
- BREAKING CHANGE: Rename `trustsec_download_enviroment_data_every_x_seconds` attribute of `ise_network_device` resource to `trustsec_download_environment_data_every_x_seconds`
- Fix issue with incorrect generated ranks in multiple policies [link](https://github.com/netascode/terraform-ise-nac-ise/issues/21)
- Fix update-in-place during import in `ise_user_identity_group`, `ise_endpoint_identity_group` and `network_device_group`
- Fix update-in-place during `ise_device_admin_condition`, `ise_device_admin_time_and_date_condition` and `ise_device_admin_policy_set`
- Fix update-in-place during `ise_network_access_condition`, `ise_network_access_time_and_date_condition` and `ise_network_access_policy_set`

## 0.1.2

- Add `parent_group` attribute to `user_identity_group`
- Support new `*_update_rank` resources to allow changing the rank of policy sets or rules without impacting existing configurations
- Support active directory configurations without groups
- Added support for managing endpoints
- Added support for default user identity groups assignment under internal users
- Fix incorrect description attribute of `network_device_groups` configuration
- BREAKING CHANGE: `endpoint_identity_groups` and `user_identity_groups` now support nested children in favor of `parent` references

## 0.1.1

- Fix issue with error due to missing settings for `allowed_protocols` and EAP-TLS stateless session resume
- Add support for active directory configuration
- Added `ise_identity_source_sequence` support
- BREAKING CHANGE: Split `attribute_name` to `dictionary_name` and `attribute_name`
- BREAKING CHANGE: Removed `manage_*` variables
- Allow updating default policy sets and rules

## 0.1.0

- Initial release
