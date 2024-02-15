resource "ise_allowed_protocols" "allowed_protocols" {
  for_each = { for protocol in try(local.ise.network_access.policy_elements.allowed_protocols, []) : protocol.name => protocol }

  description                                       = try(each.value.description, "")
  name                                              = each.key
  process_host_lookup                               = try(each.value.process_host_lookup, local.defaults.ise.network_access.policy_elements.allowed_protocols.process_host_lookup, null)
  allow_pap_ascii                                   = try(each.value.allow_pap_ascii, local.defaults.ise.network_access.policy_elements.allowed_protocols.allow_pap_ascii, null)
  allow_chap                                        = try(each.value.allow_chap, local.defaults.ise.network_access.policy_elements.allowed_protocols.allow_chap, null)
  allow_ms_chap_v1                                  = try(each.value.allow_ms_chap_v1, local.defaults.ise.network_access.policy_elements.allowed_protocols.allow_ms_chap_v1, null)
  allow_ms_chap_v2                                  = try(each.value.allow_ms_chap_v2, local.defaults.ise.network_access.policy_elements.allowed_protocols.allow_ms_chap_v2, null)
  allow_eap_md5                                     = try(each.value.allow_eap_md5, local.defaults.ise.network_access.policy_elements.allowed_protocols.allow_eap_md5, null)
  allow_leap                                        = try(each.value.allow_leap, local.defaults.ise.network_access.policy_elements.allowed_protocols.allow_leap, null)
  allow_eap_tls                                     = try(each.value.allow_eap_tls, local.defaults.ise.network_access.policy_elements.allowed_protocols.allow_eap_tls, null)
  allow_eap_ttls                                    = try(each.value.allow_eap_ttls, local.defaults.ise.network_access.policy_elements.allowed_protocols.allow_eap_ttls, null)
  allow_eap_fast                                    = try(each.value.allow_eap_fast, local.defaults.ise.network_access.policy_elements.allowed_protocols.allow_eap_fast, null)
  allow_peap                                        = try(each.value.allow_peap, local.defaults.ise.network_access.policy_elements.allowed_protocols.allow_peap, null)
  allow_teap                                        = try(each.value.allow_teap, local.defaults.ise.network_access.policy_elements.allowed_protocols.allow_teap, null)
  allow_5g                                          = try(each.value.five_g, local.defaults.ise.network_access.policy_elements.allowed_protocols.five_g, null)
  allow_preferred_eap_protocol                      = try(each.value.allow_preferred_eap_protocol, local.defaults.ise.network_access.policy_elements.allowed_protocols.allow_preferred_eap_protocol, null)
  eap_tls_l_bit                                     = try(each.value.eap_tls_l_bit, local.defaults.ise.network_access.policy_elements.allowed_protocols.eap_tls_l_bit, null)
  allow_weak_ciphers_for_eap                        = try(each.value.allow_weak_ciphers_for_eap, local.defaults.ise.network_access.policy_elements.allowed_protocols.allow_weak_ciphers_for_eap, null)
  require_message_auth                              = try(each.value.require_message_auth, local.defaults.ise.network_access.policy_elements.allowed_protocols.require_message_auth, null)
  eap_tls_allow_auth_of_expired_certs               = try(each.value.allow_eap_tls, local.defaults.ise.network_access.policy_elements.allowed_protocols.allow_eap_tls, false) ? try(each.value.eap_tls.auth_of_expired_certs, local.defaults.ise.network_access.policy_elements.allowed_protocols.eap_tls.auth_of_expired_certs, null) : null
  eap_tls_enable_stateless_session_resume           = try(each.value.allow_eap_tls, local.defaults.ise.network_access.policy_elements.allowed_protocols.allow_eap_tls, false) ? try(each.value.eap_tls.enable_stateless_session_resume, local.defaults.ise.network_access.policy_elements.allowed_protocols.eap_tls.enable_stateless_session_resume, null) : null
  eap_tls_session_ticket_ttl                        = try(each.value.eap_tls.enable_stateless_session_resume, local.defaults.ise.network_access.policy_elements.allowed_protocols.eap_tls.enable_stateless_session_resume, false) ? try(each.value.eap_tls.session_ticket_ttl, local.defaults.ise.network_access.policy_elements.allowed_protocols.eap_tls.session_ticket_ttl, null) : null
  eap_tls_session_ticket_ttl_unit                   = try(each.value.eap_tls.enable_stateless_session_resume, local.defaults.ise.network_access.policy_elements.allowed_protocols.eap_tls.enable_stateless_session_resume, false) ? try(each.value.eap_tls.session_ticket_ttl_unit, local.defaults.ise.network_access.policy_elements.allowed_protocols.eap_tls.session_ticket_ttl_unit, null) : null
  eap_tls_session_ticket_percentage                 = try(each.value.eap_tls.enable_stateless_session_resume, local.defaults.ise.network_access.policy_elements.allowed_protocols.eap_tls.enable_stateless_session_resume, false) ? try(each.value.eap_tls.session_ticket_percentage, local.defaults.ise.network_access.policy_elements.allowed_protocols.eap_tls.session_ticket_percentage, null) : null
  peap_allow_peap_eap_ms_chap_v2                    = try(each.value.allow_peap, local.defaults.ise.network_access.policy_elements.allowed_protocols.allow_peap, false) ? try(each.value.peap.eap_ms_chap_v2, local.defaults.ise.network_access.policy_elements.allowed_protocols.peap.eap_ms_chap_v2, null) : null
  peap_allow_peap_eap_ms_chap_v2_pwd_change         = try(each.value.allow_peap, local.defaults.ise.network_access.policy_elements.allowed_protocols.allow_peap, false) && try(each.value.peap.eap_ms_chap_v2, local.defaults.ise.network_access.policy_elements.allowed_protocols.peap.eap_ms_chap_v2, false) ? try(each.value.peap.eap_ms_chap_v2_pwd_change, local.defaults.ise.network_access.policy_elements.allowed_protocols.peap.eap_ms_chap_v2_pwd_change, null) : null
  peap_allow_peap_eap_ms_chap_v2_pwd_change_retries = try(each.value.allow_peap, local.defaults.ise.network_access.policy_elements.allowed_protocols.allow_peap, false) && try(each.value.peap.eap_ms_chap_v2, local.defaults.ise.network_access.policy_elements.allowed_protocols.peap.eap_ms_chap_v2, false) ? try(each.value.peap.eap_ms_chap_v2_pwd_change_retries, local.defaults.ise.network_access.policy_elements.allowed_protocols.peap.eap_ms_chap_v2_pwd_change_retries, null) : null
  peap_allow_peap_eap_gtc                           = try(each.value.allow_peap, local.defaults.ise.network_access.policy_elements.allowed_protocols.allow_peap, false) ? try(each.value.peap.eap_gtc, local.defaults.ise.network_access.policy_elements.allowed_protocols.peap.eap_gtc, null) : null
  peap_allow_peap_eap_gtc_pwd_change                = try(each.value.allow_peap, local.defaults.ise.network_access.policy_elements.allowed_protocols.allow_peap, false) && try(each.value.peap.eap_gtc, local.defaults.ise.network_access.policy_elements.allowed_protocols.peap.eap_gtc, false) ? try(each.value.peap.eap_gtc_pwd_change, local.defaults.ise.network_access.policy_elements.allowed_protocols.peap.eap_gtc_pwd_change, null) : null
  peap_allow_peap_eap_gtc_pwd_change_retries        = try(each.value.allow_peap, local.defaults.ise.network_access.policy_elements.allowed_protocols.allow_peap, false) && try(each.value.peap.eap_gtc, local.defaults.ise.network_access.policy_elements.allowed_protocols.peap.eap_gtc, false) ? try(each.value.peap.eap_gtc_pwd_change_retries, local.defaults.ise.network_access.policy_elements.allowed_protocols.peap.eap_gtc_pwd_change_retries, null) : null
  peap_allow_peap_eap_tls                           = try(each.value.allow_peap, local.defaults.ise.network_access.policy_elements.allowed_protocols.allow_peap, false) ? try(each.value.peap.eap_tls, local.defaults.ise.network_access.policy_elements.allowed_protocols.peap.eap_tls, null) : null
  peap_allow_peap_eap_tls_auth_of_expired_certs     = try(each.value.allow_peap, local.defaults.ise.network_access.policy_elements.allowed_protocols.allow_peap, false) ? try(each.value.peap.eap_tls_auth_of_expired_certs, local.defaults.ise.network_access.policy_elements.allowed_protocols.peap.eap_tls_auth_of_expired_certs, null) : null
  require_cryptobinding                             = try(each.value.allow_peap, local.defaults.ise.network_access.policy_elements.allowed_protocols.allow_peap, false) ? try(each.value.peap.require_cryptobinding, local.defaults.ise.network_access.policy_elements.allowed_protocols.peap.require_cryptobinding, null) : null
  peap_peap_v0                                      = try(each.value.allow_peap, local.defaults.ise.network_access.policy_elements.allowed_protocols.allow_peap, false) ? try(each.value.peap.peap_v0, local.defaults.ise.network_access.policy_elements.allowed_protocols.peap.peap_v0, null) : null
  eap_ttls_pap_ascii                                = try(each.value.allow_eap_ttls, local.defaults.ise.network_access.policy_elements.allowed_protocols.allow_eap_ttls, false) ? try(each.value.eap_ttls.pap_ascii, local.defaults.ise.network_access.policy_elements.allowed_protocols.eap_ttls.pap_ascii, null) : null
  eap_ttls_chap                                     = try(each.value.allow_eap_ttls, local.defaults.ise.network_access.policy_elements.allowed_protocols.allow_eap_ttls, false) ? try(each.value.eap_ttls.chap, local.defaults.ise.network_access.policy_elements.allowed_protocols.eap_ttls.chap, null) : null
  eap_ttls_ms_chap_v1                               = try(each.value.allow_eap_ttls, local.defaults.ise.network_access.policy_elements.allowed_protocols.allow_eap_ttls, false) ? try(each.value.eap_ttls.ms_chap_v1, local.defaults.ise.network_access.policy_elements.allowed_protocols.eap_ttls.ms_chap_v1, null) : null
  eap_ttls_ms_chap_v2                               = try(each.value.allow_eap_ttls, local.defaults.ise.network_access.policy_elements.allowed_protocols.allow_eap_ttls, false) ? try(each.value.eap_ttls.ms_chap_v2, local.defaults.ise.network_access.policy_elements.allowed_protocols.eap_ttls.ms_chap_v2, null) : null
  eap_ttls_eap_md5                                  = try(each.value.allow_eap_ttls, local.defaults.ise.network_access.policy_elements.allowed_protocols.allow_eap_ttls, false) ? try(each.value.eap_ttls.eap_md5, local.defaults.ise.network_access.policy_elements.allowed_protocols.eap_ttls.eap_md5, null) : null
  eap_ttls_eap_ms_chap_v2                           = try(each.value.allow_eap_ttls, local.defaults.ise.network_access.policy_elements.allowed_protocols.allow_eap_ttls, false) ? try(each.value.eap_ttls.eap_ms_chap_v2, local.defaults.ise.network_access.policy_elements.allowed_protocols.eap_ttls.eap_ms_chap_v2, null) : null
  eap_ttls_eap_ms_chap_v2_pwd_change                = try(each.value.allow_eap_ttls, local.defaults.ise.network_access.policy_elements.allowed_protocols.allow_eap_ttls, false) && try(each.value.eap_ttls.eap_ms_chap_v2, local.defaults.ise.network_access.policy_elements.allowed_protocols.eap_ttls.eap_ms_chap_v2, false) ? try(each.value.eap_ttls.eap_ms_chap_v2_pwd_change, local.defaults.ise.network_access.policy_elements.allowed_protocols.eap_ttls.eap_ms_chap_v2_pwd_change, null) : null
  eap_ttls_eap_ms_chap_v2_pwd_change_retries        = try(each.value.allow_eap_ttls, local.defaults.ise.network_access.policy_elements.allowed_protocols.allow_eap_ttls, false) && try(each.value.eap_ttls.eap_ms_chap_v2, local.defaults.ise.network_access.policy_elements.allowed_protocols.eap_ttls.eap_ms_chap_v2, false) ? try(each.value.eap_ttls.eap_ms_chap_v2_pwd_change_retries, local.defaults.ise.network_access.policy_elements.allowed_protocols.eap_ttls.eap_ms_chap_v2_pwd_change_retries, null) : null
  eap_fast_eap_ms_chap_v2                           = try(each.value.allow_eap_fast, local.defaults.ise.network_access.policy_elements.allowed_protocols.allow_eap_fast, false) ? try(each.value.eap_fast.eap_ms_chap_v2, local.defaults.ise.network_access.policy_elements.allowed_protocols.eap_fast.eap_ms_chap_v2, null) : null
  eap_fast_eap_ms_chap_v2_pwd_change                = try(each.value.allow_eap_fast, local.defaults.ise.network_access.policy_elements.allowed_protocols.allow_eap_fast, false) && try(each.value.eap_fast.eap_ms_chap_v2, local.defaults.ise.network_access.policy_elements.allowed_protocols.eap_fast.eap_ms_chap_v2, false) ? try(each.value.eap_fast.eap_ms_chap_v2_pwd_change, local.defaults.ise.network_access.policy_elements.allowed_protocols.eap_fast.eap_ms_chap_v2_pwd_change, null) : null
  eap_fast_eap_ms_chap_v2_pwd_change_retries        = try(each.value.allow_eap_fast, local.defaults.ise.network_access.policy_elements.allowed_protocols.allow_eap_fast, false) && try(each.value.eap_fast.eap_ms_chap_v2, local.defaults.ise.network_access.policy_elements.allowed_protocols.eap_fast.eap_ms_chap_v2, false) ? try(each.value.eap_fast.eap_ms_chap_v2_pwd_change_retries, local.defaults.ise.network_access.policy_elements.allowed_protocols.eap_fast.eap_ms_chap_v2_pwd_change_retries, null) : null
  eap_fast_eap_gtc                                  = try(each.value.allow_eap_fast, local.defaults.ise.network_access.policy_elements.allowed_protocols.allow_eap_fast, false) ? try(each.value.eap_fast.eap_gtc, local.defaults.ise.network_access.policy_elements.allowed_protocols.eap_fast.eap_gtc, null) : null
  eap_fast_eap_gtc_pwd_change                       = try(each.value.allow_eap_fast, local.defaults.ise.network_access.policy_elements.allowed_protocols.allow_eap_fast, false) && try(each.value.eap_fast.eap_gtc, local.defaults.ise.network_access.policy_elements.allowed_protocols.eap_fast.eap_gtc, false) ? try(each.value.eap_fast.eap_gtc_pwd_change, local.defaults.ise.network_access.policy_elements.allowed_protocols.eap_fast.eap_gtc_pwd_change, null) : null
  eap_fast_eap_gtc_pwd_change_retries               = try(each.value.allow_eap_fast, local.defaults.ise.network_access.policy_elements.allowed_protocols.allow_eap_fast, false) && try(each.value.eap_fast.eap_gtc, local.defaults.ise.network_access.policy_elements.allowed_protocols.eap_fast.eap_gtc, false) ? try(each.value.eap_fast.eap_gtc_pwd_change_retries, local.defaults.ise.network_access.policy_elements.allowed_protocols.eap_fast.eap_gtc_pwd_change_retries, null) : null
  eap_fast_eap_tls                                  = try(each.value.allow_eap_fast, local.defaults.ise.network_access.policy_elements.allowed_protocols.allow_eap_fast, false) ? try(each.value.eap_fast.eap_tls, local.defaults.ise.network_access.policy_elements.allowed_protocols.eap_fast.eap_tls, null) : null
  eap_fast_eap_tls_auth_of_expired_certs            = try(each.value.allow_eap_fast, local.defaults.ise.network_access.policy_elements.allowed_protocols.allow_eap_fast, false) ? try(each.value.eap_fast.eap_tls_auth_of_expired_certs, local.defaults.ise.network_access.policy_elements.allowed_protocols.eap_fast.eap_tls_auth_of_expired_certs, null) : null
  eap_fast_use_pacs                                 = try(each.value.allow_eap_fast, local.defaults.ise.network_access.policy_elements.allowed_protocols.allow_eap_fast, false) ? try(each.value.eap_fast.use_pacs, local.defaults.ise.network_access.policy_elements.allowed_protocols.eap_fast.use_pacs, null) : null
  eap_fast_pacs_tunnel_pac_ttl                      = try(each.value.allow_eap_fast, local.defaults.ise.network_access.policy_elements.allowed_protocols.allow_eap_fast, false) ? try(each.value.eap_fast.use_pacs_tunnel_pac_ttl, local.defaults.ise.network_access.policy_elements.allowed_protocols.eap_fast.use_pacs_tunnel_pac_ttl, null) : null
  eap_fast_pacs_tunnel_pac_ttl_unit                 = try(each.value.allow_eap_fast, local.defaults.ise.network_access.policy_elements.allowed_protocols.allow_eap_fast, false) ? try(each.value.eap_fast.use_pacs_tunnel_pac_ttl_units, local.defaults.ise.network_access.policy_elements.allowed_protocols.eap_fast.use_pacs_tunnel_pac_ttl_units, null) : null
  eap_fast_pacs_use_proactive_pac_update_percentage = try(each.value.allow_eap_fast, local.defaults.ise.network_access.policy_elements.allowed_protocols.allow_eap_fast, false) ? try(each.value.eap_fast.use_pacs_use_proactive_pac_update_precentage, local.defaults.ise.network_access.policy_elements.allowed_protocols.eap_fast.use_pacs_use_proactive_pac_update_precentage, null) : null
  eap_fast_pacs_allow_anonymous_provisioning        = try(each.value.allow_eap_fast, local.defaults.ise.network_access.policy_elements.allowed_protocols.allow_eap_fast, false) ? try(each.value.eap_fast.use_pacs_allow_anonym_provisioning, local.defaults.ise.network_access.policy_elements.allowed_protocols.eap_fast.use_pacs_allow_anonym_provisioning, null) : null
  eap_fast_pacs_allow_authenticated_provisioning    = try(each.value.allow_eap_fast, local.defaults.ise.network_access.policy_elements.allowed_protocols.allow_eap_fast, false) ? try(each.value.eap_fast.use_pacs_allow_authen_provisioning, local.defaults.ise.network_access.policy_elements.allowed_protocols.eap_fast.use_pacs_allow_authen_provisioning, null) : null
  eap_fast_pacs_allow_client_cert                   = try(each.value.allow_eap_fast, local.defaults.ise.network_access.policy_elements.allowed_protocols.allow_eap_fast, false) && try(each.value.eap_fast.use_pacs_allow_authen_provisioning, local.defaults.ise.network_access.policy_elements.allowed_protocols.eap_fast.use_pacs_allow_authen_provisioning) ? try(each.value.eap_fast.use_pacs_accept_client_cert, local.defaults.ise.network_access.policy_elements.allowed_protocols.eap_fast.use_pacs_accept_client_cert, null) : null
  eap_fast_pacs_server_returns                      = try(each.value.allow_eap_fast, local.defaults.ise.network_access.policy_elements.allowed_protocols.allow_eap_fast, false) && try(each.value.eap_fast.use_pacs_allow_authen_provisioning, local.defaults.ise.network_access.policy_elements.allowed_protocols.eap_fast.use_pacs_allow_authen_provisioning) ? try(each.value.eap_fast.use_pacs_server_returns, local.defaults.ise.network_access.policy_elements.allowed_protocols.eap_fast.use_pacs_server_returns, null) : null
  eap_fast_pacs_allow_machine_authentication        = try(each.value.allow_eap_fast, local.defaults.ise.network_access.policy_elements.allowed_protocols.allow_eap_fast, false) ? try(each.value.eap_fast.use_pacs_allow_machine_authentication, local.defaults.ise.network_access.policy_elements.allowed_protocols.eap_fast.use_pacs_allow_machine_authentication, null) : null
  eap_fast_pacs_machine_pac_ttl                     = try(each.value.allow_eap_fast, local.defaults.ise.network_access.policy_elements.allowed_protocols.allow_eap_fast, false) && try(each.value.eap_fast.use_pacs_allow_machine_authentication, local.defaults.ise.network_access.policy_elements.allowed_protocols.eap_fast.use_pacs_allow_machine_authentication, false) ? try(each.value.eap_fast.use_pacs_machine_pac_ttl, local.defaults.ise.network_access.policy_elements.allowed_protocols.eap_fast.use_pacs_machine_pac_ttl, null) : null
  eap_fast_pacs_machine_pac_ttl_unit                = try(each.value.allow_eap_fast, local.defaults.ise.network_access.policy_elements.allowed_protocols.allow_eap_fast, false) && try(each.value.eap_fast.use_pacs_allow_machine_authentication, local.defaults.ise.network_access.policy_elements.allowed_protocols.eap_fast.use_pacs_allow_machine_authentication, false) ? try(each.value.eap_fast.use_pacs_machine_pac_ttl_units, local.defaults.ise.network_access.policy_elements.allowed_protocols.eap_fast.use_pacs_machine_pac_ttl_units, null) : null
  eap_fast_pacs_stateless_session_resume            = try(each.value.allow_eap_fast, local.defaults.ise.network_access.policy_elements.allowed_protocols.allow_eap_fast, false) ? try(each.value.eap_fast.use_pacs_stateless_session_resume, local.defaults.ise.network_access.policy_elements.allowed_protocols.eap_fast.use_pacs_stateless_session_resume, null) : null
  eap_fast_pacs_authorization_pac_ttl               = try(each.value.allow_eap_fast, local.defaults.ise.network_access.policy_elements.allowed_protocols.allow_eap_fast, false) ? try(each.value.eap_fast.use_pacs_authorization_pac_ttl, local.defaults.ise.network_access.policy_elements.allowed_protocols.eap_fast.use_pacs_authorization_pac_ttl, null) : null
  eap_fast_pacs_authorization_pac_ttl_unit          = try(each.value.allow_eap_fast, local.defaults.ise.network_access.policy_elements.allowed_protocols.allow_eap_fast, false) ? try(each.value.eap_fast.use_pacs_authorization_pac_ttl_units, local.defaults.ise.network_access.policy_elements.allowed_protocols.eap_fast.use_pacs_authorization_pac_ttl_units, null) : null
  eap_fast_enable_eap_chaining                      = try(each.value.allow_eap_fast, local.defaults.ise.network_access.policy_elements.allowed_protocols.allow_eap_fast, false) ? try(each.value.eap_fast.enable_eap_chaining, local.defaults.ise.network_access.policy_elements.allowed_protocols.eap_fast.enable_eap_chaining, null) : null
  teap_eap_ms_chap_v2                               = try(each.value.allow_teap, local.defaults.ise.network_access.policy_elements.allowed_protocols.allow_teap, false) ? try(each.value.teap.eap_ms_chap_v2, local.defaults.ise.network_access.policy_elements.allowed_protocols.teap.eap_ms_chap_v2, null) : null
  teap_eap_ms_chap_v2_pwd_change                    = try(each.value.allow_teap, local.defaults.ise.network_access.policy_elements.allowed_protocols.allow_teap, false) && try(each.value.teap.eap_ms_chap_v2, local.defaults.ise.network_access.policy_elements.allowed_protocols.teap.eap_ms_chap_v2, false) ? try(each.value.teap.eap_ms_chap_v2_pwd_change, local.defaults.ise.network_access.policy_elements.allowed_protocols.teap.eap_ms_chap_v2_pwd_change, null) : null
  teap_eap_ms_chap_v2_pwd_change_retries            = try(each.value.allow_teap, local.defaults.ise.network_access.policy_elements.allowed_protocols.allow_teap, false) && try(each.value.teap.eap_ms_chap_v2, local.defaults.ise.network_access.policy_elements.allowed_protocols.teap.eap_ms_chap_v2, false) ? try(each.value.teap.eap_ms_chap_v2_pwd_change_retries, local.defaults.ise.network_access.policy_elements.allowed_protocols.teap.eap_ms_chap_v2_pwd_change_retries, null) : null
  teap_eap_tls                                      = try(each.value.allow_teap, local.defaults.ise.network_access.policy_elements.allowed_protocols.allow_teap, false) ? try(each.value.teap.eap_tls, local.defaults.ise.network_access.policy_elements.allowed_protocols.teap.eap_tls, null) : null
  teap_eap_tls_auth_of_expired_certs                = try(each.value.allow_teap, local.defaults.ise.network_access.policy_elements.allowed_protocols.allow_teap, false) ? try(each.value.teap.eap_tls_auth_of_expired_certs, local.defaults.ise.network_access.policy_elements.allowed_protocols.teap.eap_tls_auth_of_expired_certs, null) : null
  teap_eap_accept_client_cert_during_tunnel_est     = try(each.value.allow_teap, local.defaults.ise.network_access.policy_elements.allowed_protocols.allow_teap, false) ? try(each.value.teap.accept_client_cert_during_tunnel_est, local.defaults.ise.network_access.policy_elements.allowed_protocols.teap.accept_client_cert_during_tunnel_est, null) : null
  teap_eap_chaining                                 = try(each.value.allow_teap, local.defaults.ise.network_access.policy_elements.allowed_protocols.allow_teap, false) ? try(each.value.teap.enable_eap_chaining, local.defaults.ise.network_access.policy_elements.allowed_protocols.teap.enable_eap_chaining, null) : null
  teap_downgrade_msk                                = try(each.value.allow_teap, local.defaults.ise.network_access.policy_elements.allowed_protocols.allow_teap, false) ? try(each.value.teap.allow_downgrade_msk, local.defaults.ise.network_access.policy_elements.allowed_protocols.teap.allow_downgrade_msk, null) : null
  preferred_eap_protocol                            = try(each.value.preferred_eap_protocol, local.defaults.ise.network_access.policy_elements.allowed_protocols.preferred_eap_protocol, null)
}

resource "ise_authorization_profile" "authorization_profile" {
  for_each = { for profile in try(local.ise.network_access.policy_elements.authorization_profiles, []) : profile.name => profile }

  name                                                  = each.key
  description                                           = try(each.value.description, local.defaults.ise.network_access.policy_elements.authorization_profiles.description, null)
  vlan_name_id                                          = try(each.value.vlan_name_id, local.defaults.ise.network_access.policy_elements.authorization_profiles.vlan_name_id, null)
  vlan_tag_id                                           = try(each.value.vlan_tag_id, local.defaults.ise.network_access.policy_elements.authorization_profiles.vlan_tag_id, null)
  web_redirection_type                                  = try(each.value.web_redirection.type, local.defaults.ise.network_access.policy_elements.authorization_profiles.web_redirection.type, null)
  web_redirection_acl                                   = try(each.value.web_redirection.acl, local.defaults.ise.network_access.policy_elements.authorization_profiles.web_redirection.acl, null)
  web_redirection_portal_name                           = try(each.value.web_redirection.portal_name, local.defaults.ise.network_access.policy_elements.authorization_profiles.web_redirection.portal_name, null)
  web_redirection_static_ip_host_name_fqdn              = try(each.value.web_redirection.static_ip_host_name_fqdn, local.defaults.ise.network_access.policy_elements.authorization_profiles.web_redirection.static_ip_host_name_fqdn, null)
  web_redirection_display_certificates_renewal_messages = try(each.value.web_redirection.display_certificates_renewal_messages, local.defaults.ise.network_access.policy_elements.authorization_profiles.web_redirection.display_certificates_renewal_messages, null)
  agentless_posture                                     = try(each.value.agentless_posture, local.defaults.ise.network_access.policy_elements.authorization_profiles.agentless_posture, null)
  access_type                                           = try(each.value.access_type, local.defaults.ise.network_access.policy_elements.authorization_profiles.access_type, null)
  profile_name                                          = try(each.value.profile_name, local.defaults.ise.network_access.policy_elements.authorization_profiles.profile_name, null)
  airespace_acl                                         = try(each.value.airespace_acl, local.defaults.ise.network_access.policy_elements.authorization_profiles.airespace_acl, null)
  acl                                                   = try(each.value.acl, local.defaults.ise.network_access.policy_elements.authorization_profiles.acl, null)
  dacl_name                                             = try(each.value.dacl_name, local.defaults.ise.network_access.policy_elements.authorization_profiles.dacl_name, null)
  ipv6_dacl_name                                        = try(each.value.ipv6_dacl_name, local.defaults.ise.network_access.policy_elements.authorization_profiles.ipv6_dacl_name, null)
  auto_smart_port                                       = try(each.value.auto_smart_port, local.defaults.ise.network_access.policy_elements.authorization_profiles.auto_smart_port, null)
  interface_template                                    = try(each.value.interface_template, local.defaults.ise.network_access.policy_elements.authorization_profiles.interface_template, null)
  ipv6_acl_filter                                       = try(each.value.ipv6_acl_filter, local.defaults.ise.network_access.policy_elements.authorization_profiles.ipv6_acl_filter, null)
  avc_profile                                           = try(each.value.avc_profile, local.defaults.ise.network_access.policy_elements.authorization_profiles.avc_profile, null)
  asa_vpn                                               = try(each.value.asa_vpn, local.defaults.ise.network_access.policy_elements.authorization_profiles.asa_vpn, null)
  unique_identifier                                     = try(each.value.unique_identifier, local.defaults.ise.network_access.policy_elements.authorization_profiles.unique_identifier, null)
  track_movement                                        = try(each.value.track_movement, local.defaults.ise.network_access.policy_elements.authorization_profiles.track_movement, null)
  service_template                                      = try(each.value.service_template, local.defaults.ise.network_access.policy_elements.authorization_profiles.service_template, null)
  easywired_session_candidate                           = try(each.value.easywired_session_candidate, local.defaults.ise.network_access.policy_elements.authorization_profiles.easywired_session_candidate, null)
  voice_domain_permission                               = try(each.value.voice_domain_permission, local.defaults.ise.network_access.policy_elements.authorization_profiles.voice_domain_permission, null)
  neat                                                  = try(each.value.neat, local.defaults.ise.network_access.policy_elements.authorization_profiles.neat, null)
  web_auth                                              = try(each.value.web_auth, local.defaults.ise.network_access.policy_elements.authorization_profiles.web_auth, null)
  mac_sec_policy                                        = try(each.value.mac_sec_policy, local.defaults.ise.network_access.policy_elements.authorization_profiles.mac_sec_policy, null)
  reauthentication_connectivity                         = try(each.value.reauthentication_connectivity, local.defaults.ise.network_access.policy_elements.authorization_profiles.reauthentication_connectivity, null)
  reauthentication_timer                                = try(each.value.reauthentication_timer, local.defaults.ise.network_access.policy_elements.authorization_profiles.reauthentication_timer, null)
  airespace_ipv6_acl                                    = try(each.value.airespace_ipv6_acl, local.defaults.ise.network_access.policy_elements.authorization_profiles.airespace_ipv6_acl, null)
  advanced_attributes = try([for i in each.value.advanced_attributes : {
    attribute_left_dictionary_name  = try(split(":", i.name)[0], null)
    attribute_left_name             = try(split(":", i.name)[1], null)
    attribute_right_value_type      = try(split(":", i.value)[1], null) != null ? "AdvancedDictionaryAttribute" : "AttributeValue"
    attribute_right_dictionary_name = try(split(":", i.value)[1], null) != null ? split(":", i.value)[0] : null
    attribute_right_name            = try(split(":", i.value)[1], null) != null ? split(":", i.value)[1] : null
    attribute_right_value           = try(split(":", i.value)[1], null) != null ? null : i.attribute_value
  }], null)

  lifecycle {
    create_before_destroy = true
  }

  depends_on = [ise_downloadable_acl.downloadable_acl, ise_active_directory_add_groups.active_directory_groups]
}

locals {
  network_access_conditions_circular_names = distinct(flatten([
    for v in try(local.ise.network_access.policy_elements.conditions, []) : [
      for v2 in try(v.children, []) : try(v2.type, null) == "ConditionReference" ? [[v2.name]] : [
        for v3 in try(v2.children, []) : try(v3.type, null) == "ConditionReference" ? [v3.name] : []
      ]
    ]
  ]))
}

data "ise_network_access_condition" "network_access_condition_circular" {
  for_each = toset(local.network_access_conditions_circular_names)

  name = each.value
}

resource "ise_network_access_condition" "network_access_condition" {
  for_each = { for condition in try(local.ise.network_access.policy_elements.conditions, []) : condition.name => condition }

  condition_type   = try(each.value.type, local.defaults.ise.network_access.policy_elements.conditions.type, null)
  is_negate        = try(each.value.is_negate, local.defaults.ise.network_access.policy_elements.conditions.is_negate, null)
  attribute_name   = try(each.value.attribute_name, local.defaults.ise.network_access.policy_elements.conditions.attribute_name, null)
  attribute_value  = try(each.value.attribute_value, local.defaults.ise.network_access.policy_elements.conditions.attribute_value, null)
  dictionary_name  = try(each.value.dictionary_name, local.defaults.ise.network_access.policy_elements.conditions.dictionary_name, null)
  dictionary_value = try(each.value.dictionary_value, local.defaults.ise.network_access.policy_elements.conditions.dictionary_value, null)
  operator         = try(each.value.operator, local.defaults.ise.network_access.policy_elements.conditions.operator, null)
  description      = try(each.value.description, local.defaults.ise.network_access.policy_elements.conditions.description, null)
  name             = each.key
  children = [for c in try(each.value.children, []) : {
    attribute_name   = try(c.attribute_name, local.defaults.ise.network_access.policy_elements.conditions.attribute_name, null)
    attribute_value  = try(c.attribute_value, local.defaults.ise.network_access.policy_elements.conditions.attribute_value, null)
    dictionary_name  = try(c.dictionary_name, local.defaults.ise.network_access.policy_elements.conditions.dictionary_name, null)
    dictionary_value = try(c.dictionary_value, local.defaults.ise.network_access.policy_elements.conditions.dictionary_value, null)
    condition_type   = try(c.type, local.defaults.ise.network_access.policy_elements.conditions.type, null)
    is_negate        = try(c.is_negate, local.defaults.ise.network_access.policy_elements.conditions.is_negate, null)
    operator         = try(c.operator, local.defaults.ise.network_access.policy_elements.conditions.operator, null)
    name             = try(c.name, null)
    id               = try(c.type, local.defaults.ise.network_access.policy_elements.conditions.type, null) == "ConditionReference" ? data.ise_network_access_condition.network_access_condition_circular[c.name].id : null
    children = [for c2 in try(c.children, []) : {
      attribute_name   = try(c2.attribute_name, local.defaults.ise.network_access.policy_elements.conditions.attribute_name, null)
      attribute_value  = try(c2.attribute_value, local.defaults.ise.network_access.policy_elements.conditions.attribute_value, null)
      dictionary_name  = try(c2.dictionary_name, local.defaults.ise.network_access.policy_elements.conditions.dictionary_name, null)
      dictionary_value = try(c2.dictionary_value, local.defaults.ise.network_access.policy_elements.conditions.dictionary_value, null)
      condition_type   = try(c2.type, local.defaults.ise.network_access.policy_elements.conditions.type, null)
      is_negate        = try(c2.is_negate, local.defaults.ise.network_access.policy_elements.conditions.is_negate, null)
      operator         = try(c2.operator, local.defaults.ise.network_access.policy_elements.conditions.operator, null)
      name             = try(c2.name, null)
      id               = try(c2.type, local.defaults.ise.network_access.policy_elements.conditions.type, null) == "ConditionReference" ? data.ise_network_access_condition.network_access_condition_circular[c2.name].id : null
    }]
  }]

  depends_on = [ise_active_directory_add_groups.active_directory_groups]
}

resource "ise_downloadable_acl" "downloadable_acl" {
  for_each = { for dacl in try(local.ise.network_access.policy_elements.downloadable_acls, []) : dacl.name => dacl }

  name        = each.key
  description = try(each.value.description, local.defaults.ise.network_access.policy_elements.downloadable_acls.description, null)
  dacl        = try(each.value.dacl_content, local.defaults.ise.network_access.policy_elements.downloadable_acls.dacl_content, null)
  dacl_type   = try(each.value.dacl_type, local.defaults.ise.network_access.policy_elements.downloadable_acls.dacl_type, null)
}

resource "ise_network_access_dictionary" "network_access_dictionary" {
  for_each = { for d in try(local.ise.network_access.policy_elements.dictionaries, []) : d.name => d }

  name                 = each.key
  description          = try(each.value.description, local.defaults.ise.network_access.policy_elements.dictionaries.description, null)
  version              = try(each.value.version, local.defaults.ise.network_access.policy_elements.dictionaries.version, null)
  dictionary_attr_type = try(each.value.attribute_type, local.defaults.ise.network_access.policy_elements.dictionaries.attribute_type, null)
}

resource "ise_network_access_time_and_date_condition" "network_access_time_and_date_condition" {
  for_each = { for c in try(local.ise.network_access.policy_elements.time_date_conditions, []) : c.name => c }

  name                 = each.key
  description          = try(each.value.description, local.defaults.ise.network_access.policy_elements.time_date_conditions.description, null)
  week_days            = try(each.value.week_days, local.defaults.ise.network_access.policy_elements.time_date_conditions.week_days, null)
  week_days_exception  = try(each.value.week_days_exception, local.defaults.ise.network_access.policy_elements.time_date_conditions.week_days_exception, null)
  start_date           = try(each.value.start_date, local.defaults.ise.network_access.policy_elements.time_date_conditions.start_date, null)
  end_date             = try(each.value.end_date, local.defaults.ise.network_access.policy_elements.time_date_conditions.end_date, null)
  exception_start_date = try(each.value.exception_start_date, local.defaults.ise.network_access.policy_elements.time_date_conditions.exception_start_date, null)
  exception_end_date   = try(each.value.exception_end_date, local.defaults.ise.network_access.policy_elements.time_date_conditions.exception_end_date, null)
  start_time           = try(each.value.start_time, local.defaults.ise.network_access.policy_elements.time_date_conditions.start_time, null)
  end_time             = try(each.value.end_time, local.defaults.ise.network_access.policy_elements.time_date_conditions.end_time, null)
  exception_start_time = try(each.value.exception_start_time, local.defaults.ise.network_access.policy_elements.time_date_conditions.exception_start_time, null)
  exception_end_time   = try(each.value.exception_end_time, local.defaults.ise.network_access.policy_elements.time_date_conditions.exception_end_time, null)
}

locals {
  conditions_network_access_policy_sets = flatten([
    for v in try(local.ise.network_access.policy_sets, []) : try(v.condition.type, null) == "ConditionReference" ? [[[v.condition.name]]] : [
      for v2 in try(v.condition.children, []) : try(v2.type, null) == "ConditionReference" ? [[v2.name]] : [
        for v3 in try(v2.children, []) : try(v3.type, null) == "ConditionReference" ? [v3.name] : []
      ]
    ]
  ])
  conditions_network_access_policy_set_authentication_rules = flatten([
    for v in try(local.ise.network_access.policy_sets, []) : [
      for r in try(v.authentication_rules, []) : try(r.condition.type, null) == "ConditionReference" ? [[[r.condition.name]]] : [
        for v2 in try(r.condition.children, []) : try(v2.type, null) == "ConditionReference" ? [[v2.name]] : [
          for v3 in try(v2.children, []) : try(v3.type, null) == "ConditionReference" ? [v3.name] : []
        ]
      ]
    ]
  ])
  conditions_network_access_policy_set_authorization_rules = flatten([
    for v in try(local.ise.network_access.policy_sets, []) : [
      for r in try(v.authorization_rules, []) : try(r.condition.type, null) == "ConditionReference" ? [[[r.condition.name]]] : [
        for v2 in try(r.condition.children, []) : try(v2.type, null) == "ConditionReference" ? [[v2.name]] : [
          for v3 in try(v2.children, []) : try(v3.type, null) == "ConditionReference" ? [v3.name] : []
        ]
      ]
    ]
  ])
  conditions_network_access_policy_set_authorization_exception_rules = flatten([
    for v in try(local.ise.network_access.policy_sets, []) : [
      for r in try(v.authorization_exception_rules, []) : try(r.condition.type, null) == "ConditionReference" ? [[[r.condition.name]]] : [
        for v2 in try(r.condition.children, []) : try(v2.type, null) == "ConditionReference" ? [[v2.name]] : [
          for v3 in try(v2.children, []) : try(v3.type, null) == "ConditionReference" ? [v3.name] : []
        ]
      ]
    ]
  ])
  conditions_network_access_authorization_global_exception_rules = flatten([
    for v in try(local.ise.network_access.authorization_global_exception_rules, []) : try(v.condition.type, null) == "ConditionReference" ? [[[v.condition.name]]] : [
      for v2 in try(v.condition.children, []) : try(v2.type, null) == "ConditionReference" ? [[v2.name]] : [
        for v3 in try(v2.children, []) : try(v3.type, null) == "ConditionReference" ? [v3.name] : []
      ]
    ]
  ])
  unique_conditions_network_access  = distinct(concat(local.conditions_network_access_policy_sets, local.conditions_network_access_policy_set_authentication_rules, local.conditions_network_access_policy_set_authorization_rules, local.conditions_network_access_policy_set_authorization_exception_rules, local.conditions_network_access_authorization_global_exception_rules))
  known_conditions_network_access   = [for condition in try(local.ise.network_access.policy_elements.conditions, []) : condition.name]
  unknown_conditions_network_access = setsubtract(local.unique_conditions_network_access, local.known_conditions_network_access)
}

data "ise_network_access_condition" "network_access_condition" {
  for_each = toset(local.unknown_conditions_network_access)

  name = each.value
}

locals {
  network_access_policy_sets = [
    for ps in try(local.ise.network_access.policy_sets, []) : {
      condition_type             = try(ps.condition.type, local.defaults.ise.network_access.policy_sets.condition.type, null)
      condition_is_negate        = try(ps.condition.is_negate, local.defaults.ise.network_access.policy_sets.condition.is_negate, null)
      condition_attribute_name   = try(ps.condition.attribute_name, local.defaults.ise.network_access.policy_sets.condition.attribute_name, null)
      condition_attribute_value  = try(ps.condition.attribute_value, local.defaults.ise.network_access.policy_sets.condition.attribute_value, null)
      condition_dictionary_name  = try(ps.condition.dictionary_name, local.defaults.ise.network_access.policy_sets.condition.dictionary_name, null)
      condition_dictionary_value = try(ps.condition.dictionary_value, local.defaults.ise.network_access.policy_sets.condition.dictionary_value, null)
      condition_id               = contains(local.known_conditions_network_access, try(ps.condition.name, "")) ? ise_network_access_condition.network_access_condition[ps.condition.name].id : try(data.ise_network_access_condition.network_access_condition[ps.condition.name].id, null)
      condition_operator         = try(ps.condition.operator, local.defaults.ise.network_access.policy_sets.condition.operator, null)
      description                = try(ps.description, local.defaults.ise.network_access.policy_sets.description, null)
      is_proxy                   = try(ps.is_proxy, local.defaults.ise.network_access.policy_sets.is_proxy)
      name                       = ps.name
      service_name               = try(ps.service_name, local.defaults.ise.network_access.policy_sets.service_name)
      state                      = try(ps.state, local.defaults.ise.network_access.policy_sets.state)
      rank                       = try(ps.rank, local.defaults.ise.network_access.policy_sets.rank, null)
      children = try([for i in ps.condition.children : {
        attribute_name   = try(i.attribute_name, local.defaults.ise.network_access.policy_sets.condition.attribute_name, null),
        attribute_value  = try(i.attribute_value, local.defaults.ise.network_access.policy_sets.condition.attribute_value, null)
        dictionary_name  = try(i.dictionary_name, local.defaults.ise.network_access.policy_sets.condition.dictionary_name, null)
        dictionary_value = try(i.dictionary_value, local.defaults.ise.network_access.policy_sets.condition.dictionary_value, null)
        condition_type   = try(i.type, local.defaults.ise.network_access.policy_sets.condition.type, null)
        is_negate        = try(i.is_negate, local.defaults.ise.network_access.policy_sets.condition.is_negate, null)
        operator         = try(i.operator, local.defaults.ise.network_access.policy_sets.condition.operator, null)
        id               = contains(local.known_conditions_network_access, try(i.name, "")) ? ise_network_access_condition.network_access_condition[i.name].id : try(data.ise_network_access_condition.network_access_condition[i.name].id, null)
        children = try([for j in i.children : {
          attribute_name   = try(j.attribute_name, local.defaults.ise.network_access.policy_sets.condition.attribute_name, null)
          attribute_value  = try(j.attribute_value, local.defaults.ise.network_access.policy_sets.condition.attribute_value, null)
          dictionary_name  = try(j.dictionary_name, local.defaults.ise.network_access.policy_sets.condition.dictionary_name, null)
          dictionary_value = try(j.dictionary_value, local.defaults.ise.network_access.policy_sets.condition.dictionary_value, null)
          condition_type   = try(j.type, local.defaults.ise.network_access.policy_sets.condition.type, null)
          is_negate        = try(j.is_negate, local.defaults.ise.network_access.policy_sets.condition.is_negate, null)
          operator         = try(j.operator, local.defaults.ise.network_access.policy_sets.condition.operator, null)
          id               = contains(local.known_conditions_network_access, try(j.name, "")) ? ise_network_access_condition.network_access_condition[j.name].id : try(data.ise_network_access_condition.network_access_condition[j.name].id, null)
        }], null)
      }], null)
    }
  ]
}

resource "ise_network_access_policy_set" "network_access_policy_set_0" {
  for_each = { for ps in local.network_access_policy_sets : ps.name => ps if(ps.rank == 0 || ps.rank == null) }

  condition_type            = each.value.condition_type
  condition_is_negate       = each.value.condition_is_negate
  condition_attribute_name  = each.value.condition_attribute_name
  condition_attribute_value = each.value.condition_attribute_value
  condition_dictionary_name = each.value.condition_dictionary_name
  condition_id              = each.value.condition_id
  condition_operator        = each.value.condition_operator
  description               = each.value.description
  is_proxy                  = each.value.is_proxy
  name                      = each.value.name
  service_name              = each.value.service_name
  state                     = each.value.state
  rank                      = each.value.rank
  children                  = each.value.children

  depends_on = [ise_authorization_profile.authorization_profile, ise_allowed_protocols.allowed_protocols, ise_active_directory_add_groups.active_directory_groups]
}

resource "ise_network_access_policy_set" "network_access_policy_set_1" {
  for_each = { for ps in local.network_access_policy_sets : ps.name => ps if ps.rank == 1 }

  condition_type            = each.value.condition_type
  condition_is_negate       = each.value.condition_is_negate
  condition_attribute_name  = each.value.condition_attribute_name
  condition_attribute_value = each.value.condition_attribute_value
  condition_dictionary_name = each.value.condition_dictionary_name
  condition_id              = each.value.condition_id
  condition_operator        = each.value.condition_operator
  description               = each.value.description
  is_proxy                  = each.value.is_proxy
  name                      = each.value.name
  service_name              = each.value.service_name
  state                     = each.value.state
  rank                      = each.value.rank
  children                  = each.value.children

  depends_on = [ise_network_access_policy_set.network_access_policy_set_0, ise_active_directory_add_groups.active_directory_groups]
}

resource "ise_network_access_policy_set" "network_access_policy_set_2" {
  for_each = { for ps in local.network_access_policy_sets : ps.name => ps if ps.rank == 2 }

  condition_type            = each.value.condition_type
  condition_is_negate       = each.value.condition_is_negate
  condition_attribute_name  = each.value.condition_attribute_name
  condition_attribute_value = each.value.condition_attribute_value
  condition_dictionary_name = each.value.condition_dictionary_name
  condition_id              = each.value.condition_id
  condition_operator        = each.value.condition_operator
  description               = each.value.description
  is_proxy                  = each.value.is_proxy
  name                      = each.value.name
  service_name              = each.value.service_name
  state                     = each.value.state
  rank                      = each.value.rank
  children                  = each.value.children

  depends_on = [ise_network_access_policy_set.network_access_policy_set_1, ise_active_directory_add_groups.active_directory_groups]
}

resource "ise_network_access_policy_set" "network_access_policy_set_3" {
  for_each = { for ps in local.network_access_policy_sets : ps.name => ps if ps.rank == 3 }

  condition_type            = each.value.condition_type
  condition_is_negate       = each.value.condition_is_negate
  condition_attribute_name  = each.value.condition_attribute_name
  condition_attribute_value = each.value.condition_attribute_value
  condition_dictionary_name = each.value.condition_dictionary_name
  condition_id              = each.value.condition_id
  condition_operator        = each.value.condition_operator
  description               = each.value.description
  is_proxy                  = each.value.is_proxy
  name                      = each.value.name
  service_name              = each.value.service_name
  state                     = each.value.state
  rank                      = each.value.rank
  children                  = each.value.children

  depends_on = [ise_network_access_policy_set.network_access_policy_set_2, ise_active_directory_add_groups.active_directory_groups]
}

resource "ise_network_access_policy_set" "network_access_policy_set_4" {
  for_each = { for ps in local.network_access_policy_sets : ps.name => ps if ps.rank == 4 }

  condition_type            = each.value.condition_type
  condition_is_negate       = each.value.condition_is_negate
  condition_attribute_name  = each.value.condition_attribute_name
  condition_attribute_value = each.value.condition_attribute_value
  condition_dictionary_name = each.value.condition_dictionary_name
  condition_id              = each.value.condition_id
  condition_operator        = each.value.condition_operator
  description               = each.value.description
  is_proxy                  = each.value.is_proxy
  name                      = each.value.name
  service_name              = each.value.service_name
  state                     = each.value.state
  rank                      = each.value.rank
  children                  = each.value.children

  depends_on = [ise_network_access_policy_set.network_access_policy_set_3, ise_active_directory_add_groups.active_directory_groups]
}

resource "ise_network_access_policy_set" "network_access_policy_set_5" {
  for_each = { for ps in local.network_access_policy_sets : ps.name => ps if ps.rank == 5 }

  condition_type            = each.value.condition_type
  condition_is_negate       = each.value.condition_is_negate
  condition_attribute_name  = each.value.condition_attribute_name
  condition_attribute_value = each.value.condition_attribute_value
  condition_dictionary_name = each.value.condition_dictionary_name
  condition_id              = each.value.condition_id
  condition_operator        = each.value.condition_operator
  description               = each.value.description
  is_proxy                  = each.value.is_proxy
  name                      = each.value.name
  service_name              = each.value.service_name
  state                     = each.value.state
  rank                      = each.value.rank
  children                  = each.value.children

  depends_on = [ise_network_access_policy_set.network_access_policy_set_4, ise_active_directory_add_groups.active_directory_groups]
}

resource "ise_network_access_policy_set" "network_access_policy_set_6" {
  for_each = { for ps in local.network_access_policy_sets : ps.name => ps if ps.rank == 6 }

  condition_type            = each.value.condition_type
  condition_is_negate       = each.value.condition_is_negate
  condition_attribute_name  = each.value.condition_attribute_name
  condition_attribute_value = each.value.condition_attribute_value
  condition_dictionary_name = each.value.condition_dictionary_name
  condition_id              = each.value.condition_id
  condition_operator        = each.value.condition_operator
  description               = each.value.description
  is_proxy                  = each.value.is_proxy
  name                      = each.value.name
  service_name              = each.value.service_name
  state                     = each.value.state
  rank                      = each.value.rank
  children                  = each.value.children

  depends_on = [ise_network_access_policy_set.network_access_policy_set_5, ise_active_directory_add_groups.active_directory_groups]
}

resource "ise_network_access_policy_set" "network_access_policy_set_7" {
  for_each = { for ps in local.network_access_policy_sets : ps.name => ps if ps.rank == 7 }

  condition_type            = each.value.condition_type
  condition_is_negate       = each.value.condition_is_negate
  condition_attribute_name  = each.value.condition_attribute_name
  condition_attribute_value = each.value.condition_attribute_value
  condition_dictionary_name = each.value.condition_dictionary_name
  condition_id              = each.value.condition_id
  condition_operator        = each.value.condition_operator
  description               = each.value.description
  is_proxy                  = each.value.is_proxy
  name                      = each.value.name
  service_name              = each.value.service_name
  state                     = each.value.state
  rank                      = each.value.rank
  children                  = each.value.children

  depends_on = [ise_network_access_policy_set.network_access_policy_set_6, ise_active_directory_add_groups.active_directory_groups]
}

resource "ise_network_access_policy_set" "network_access_policy_set_8" {
  for_each = { for ps in local.network_access_policy_sets : ps.name => ps if ps.rank == 8 }

  condition_type            = each.value.condition_type
  condition_is_negate       = each.value.condition_is_negate
  condition_attribute_name  = each.value.condition_attribute_name
  condition_attribute_value = each.value.condition_attribute_value
  condition_dictionary_name = each.value.condition_dictionary_name
  condition_id              = each.value.condition_id
  condition_operator        = each.value.condition_operator
  description               = each.value.description
  is_proxy                  = each.value.is_proxy
  name                      = each.value.name
  service_name              = each.value.service_name
  state                     = each.value.state
  rank                      = each.value.rank
  children                  = each.value.children

  depends_on = [ise_network_access_policy_set.network_access_policy_set_7, ise_active_directory_add_groups.active_directory_groups]
}

resource "ise_network_access_policy_set" "network_access_policy_set_9" {
  for_each = { for ps in local.network_access_policy_sets : ps.name => ps if ps.rank == 9 }

  condition_type            = each.value.condition_type
  condition_is_negate       = each.value.condition_is_negate
  condition_attribute_name  = each.value.condition_attribute_name
  condition_attribute_value = each.value.condition_attribute_value
  condition_dictionary_name = each.value.condition_dictionary_name
  condition_id              = each.value.condition_id
  condition_operator        = each.value.condition_operator
  description               = each.value.description
  is_proxy                  = each.value.is_proxy
  name                      = each.value.name
  service_name              = each.value.service_name
  state                     = each.value.state
  rank                      = each.value.rank
  children                  = each.value.children

  depends_on = [ise_network_access_policy_set.network_access_policy_set_8, ise_active_directory_add_groups.active_directory_groups]
}

resource "ise_network_access_policy_set" "network_access_policy_set_10" {
  for_each = { for ps in local.network_access_policy_sets : ps.name => ps if ps.rank == 10 }

  condition_type            = each.value.condition_type
  condition_is_negate       = each.value.condition_is_negate
  condition_attribute_name  = each.value.condition_attribute_name
  condition_attribute_value = each.value.condition_attribute_value
  condition_dictionary_name = each.value.condition_dictionary_name
  condition_id              = each.value.condition_id
  condition_operator        = each.value.condition_operator
  description               = each.value.description
  is_proxy                  = each.value.is_proxy
  name                      = each.value.name
  service_name              = each.value.service_name
  state                     = each.value.state
  rank                      = each.value.rank
  children                  = each.value.children

  depends_on = [ise_network_access_policy_set.network_access_policy_set_9, ise_active_directory_add_groups.active_directory_groups]
}

resource "ise_network_access_policy_set" "network_access_policy_set_11" {
  for_each = { for ps in local.network_access_policy_sets : ps.name => ps if ps.rank == 11 }

  condition_type            = each.value.condition_type
  condition_is_negate       = each.value.condition_is_negate
  condition_attribute_name  = each.value.condition_attribute_name
  condition_attribute_value = each.value.condition_attribute_value
  condition_dictionary_name = each.value.condition_dictionary_name
  condition_id              = each.value.condition_id
  condition_operator        = each.value.condition_operator
  description               = each.value.description
  is_proxy                  = each.value.is_proxy
  name                      = each.value.name
  service_name              = each.value.service_name
  state                     = each.value.state
  rank                      = each.value.rank
  children                  = each.value.children

  depends_on = [ise_network_access_policy_set.network_access_policy_set_10, ise_active_directory_add_groups.active_directory_groups]
}

resource "ise_network_access_policy_set" "network_access_policy_set_12" {
  for_each = { for ps in local.network_access_policy_sets : ps.name => ps if ps.rank == 12 }

  condition_type            = each.value.condition_type
  condition_is_negate       = each.value.condition_is_negate
  condition_attribute_name  = each.value.condition_attribute_name
  condition_attribute_value = each.value.condition_attribute_value
  condition_dictionary_name = each.value.condition_dictionary_name
  condition_id              = each.value.condition_id
  condition_operator        = each.value.condition_operator
  description               = each.value.description
  is_proxy                  = each.value.is_proxy
  name                      = each.value.name
  service_name              = each.value.service_name
  state                     = each.value.state
  rank                      = each.value.rank
  children                  = each.value.children

  depends_on = [ise_network_access_policy_set.network_access_policy_set_11, ise_active_directory_add_groups.active_directory_groups]
}

resource "ise_network_access_policy_set" "network_access_policy_set_13" {
  for_each = { for ps in local.network_access_policy_sets : ps.name => ps if ps.rank == 13 }

  condition_type            = each.value.condition_type
  condition_is_negate       = each.value.condition_is_negate
  condition_attribute_name  = each.value.condition_attribute_name
  condition_attribute_value = each.value.condition_attribute_value
  condition_dictionary_name = each.value.condition_dictionary_name
  condition_id              = each.value.condition_id
  condition_operator        = each.value.condition_operator
  description               = each.value.description
  is_proxy                  = each.value.is_proxy
  name                      = each.value.name
  service_name              = each.value.service_name
  state                     = each.value.state
  rank                      = each.value.rank
  children                  = each.value.children

  depends_on = [ise_network_access_policy_set.network_access_policy_set_12, ise_active_directory_add_groups.active_directory_groups]
}

resource "ise_network_access_policy_set" "network_access_policy_set_14" {
  for_each = { for ps in local.network_access_policy_sets : ps.name => ps if ps.rank == 14 }

  condition_type            = each.value.condition_type
  condition_is_negate       = each.value.condition_is_negate
  condition_attribute_name  = each.value.condition_attribute_name
  condition_attribute_value = each.value.condition_attribute_value
  condition_dictionary_name = each.value.condition_dictionary_name
  condition_id              = each.value.condition_id
  condition_operator        = each.value.condition_operator
  description               = each.value.description
  is_proxy                  = each.value.is_proxy
  name                      = each.value.name
  service_name              = each.value.service_name
  state                     = each.value.state
  rank                      = each.value.rank
  children                  = each.value.children

  depends_on = [ise_network_access_policy_set.network_access_policy_set_13, ise_active_directory_add_groups.active_directory_groups]
}

resource "ise_network_access_policy_set" "network_access_policy_set_15" {
  for_each = { for ps in local.network_access_policy_sets : ps.name => ps if ps.rank == 15 }

  condition_type            = each.value.condition_type
  condition_is_negate       = each.value.condition_is_negate
  condition_attribute_name  = each.value.condition_attribute_name
  condition_attribute_value = each.value.condition_attribute_value
  condition_dictionary_name = each.value.condition_dictionary_name
  condition_id              = each.value.condition_id
  condition_operator        = each.value.condition_operator
  description               = each.value.description
  is_proxy                  = each.value.is_proxy
  name                      = each.value.name
  service_name              = each.value.service_name
  state                     = each.value.state
  rank                      = each.value.rank
  children                  = each.value.children

  depends_on = [ise_network_access_policy_set.network_access_policy_set_14, ise_active_directory_add_groups.active_directory_groups]
}

resource "ise_network_access_policy_set" "network_access_policy_set_16" {
  for_each = { for ps in local.network_access_policy_sets : ps.name => ps if ps.rank == 16 }

  condition_type            = each.value.condition_type
  condition_is_negate       = each.value.condition_is_negate
  condition_attribute_name  = each.value.condition_attribute_name
  condition_attribute_value = each.value.condition_attribute_value
  condition_dictionary_name = each.value.condition_dictionary_name
  condition_id              = each.value.condition_id
  condition_operator        = each.value.condition_operator
  description               = each.value.description
  is_proxy                  = each.value.is_proxy
  name                      = each.value.name
  service_name              = each.value.service_name
  state                     = each.value.state
  rank                      = each.value.rank
  children                  = each.value.children

  depends_on = [ise_network_access_policy_set.network_access_policy_set_15, ise_active_directory_add_groups.active_directory_groups]
}

resource "ise_network_access_policy_set" "network_access_policy_set_17" {
  for_each = { for ps in local.network_access_policy_sets : ps.name => ps if ps.rank == 17 }

  condition_type            = each.value.condition_type
  condition_is_negate       = each.value.condition_is_negate
  condition_attribute_name  = each.value.condition_attribute_name
  condition_attribute_value = each.value.condition_attribute_value
  condition_dictionary_name = each.value.condition_dictionary_name
  condition_id              = each.value.condition_id
  condition_operator        = each.value.condition_operator
  description               = each.value.description
  is_proxy                  = each.value.is_proxy
  name                      = each.value.name
  service_name              = each.value.service_name
  state                     = each.value.state
  rank                      = each.value.rank
  children                  = each.value.children

  depends_on = [ise_network_access_policy_set.network_access_policy_set_16, ise_active_directory_add_groups.active_directory_groups]
}

resource "ise_network_access_policy_set" "network_access_policy_set_18" {
  for_each = { for ps in local.network_access_policy_sets : ps.name => ps if ps.rank == 18 }

  condition_type            = each.value.condition_type
  condition_is_negate       = each.value.condition_is_negate
  condition_attribute_name  = each.value.condition_attribute_name
  condition_attribute_value = each.value.condition_attribute_value
  condition_dictionary_name = each.value.condition_dictionary_name
  condition_id              = each.value.condition_id
  condition_operator        = each.value.condition_operator
  description               = each.value.description
  is_proxy                  = each.value.is_proxy
  name                      = each.value.name
  service_name              = each.value.service_name
  state                     = each.value.state
  rank                      = each.value.rank
  children                  = each.value.children

  depends_on = [ise_network_access_policy_set.network_access_policy_set_17, ise_active_directory_add_groups.active_directory_groups]
}

resource "ise_network_access_policy_set" "network_access_policy_set_19" {
  for_each = { for ps in local.network_access_policy_sets : ps.name => ps if ps.rank == 19 }

  condition_type            = each.value.condition_type
  condition_is_negate       = each.value.condition_is_negate
  condition_attribute_name  = each.value.condition_attribute_name
  condition_attribute_value = each.value.condition_attribute_value
  condition_dictionary_name = each.value.condition_dictionary_name
  condition_id              = each.value.condition_id
  condition_operator        = each.value.condition_operator
  description               = each.value.description
  is_proxy                  = each.value.is_proxy
  name                      = each.value.name
  service_name              = each.value.service_name
  state                     = each.value.state
  rank                      = each.value.rank
  children                  = each.value.children

  depends_on = [ise_network_access_policy_set.network_access_policy_set_18, ise_active_directory_add_groups.active_directory_groups]
}

locals {
  network_access_policy_set_ids = merge(
    { for ps in local.network_access_policy_sets : ps.name => ise_network_access_policy_set.network_access_policy_set_0[ps.name].id if ps.rank == 0 || ps.rank == null },
    { for ps in local.network_access_policy_sets : ps.name => ise_network_access_policy_set.network_access_policy_set_1[ps.name].id if ps.rank == 1 },
    { for ps in local.network_access_policy_sets : ps.name => ise_network_access_policy_set.network_access_policy_set_2[ps.name].id if ps.rank == 2 },
    { for ps in local.network_access_policy_sets : ps.name => ise_network_access_policy_set.network_access_policy_set_3[ps.name].id if ps.rank == 3 },
    { for ps in local.network_access_policy_sets : ps.name => ise_network_access_policy_set.network_access_policy_set_4[ps.name].id if ps.rank == 4 },
    { for ps in local.network_access_policy_sets : ps.name => ise_network_access_policy_set.network_access_policy_set_5[ps.name].id if ps.rank == 5 },
    { for ps in local.network_access_policy_sets : ps.name => ise_network_access_policy_set.network_access_policy_set_6[ps.name].id if ps.rank == 6 },
    { for ps in local.network_access_policy_sets : ps.name => ise_network_access_policy_set.network_access_policy_set_7[ps.name].id if ps.rank == 7 },
    { for ps in local.network_access_policy_sets : ps.name => ise_network_access_policy_set.network_access_policy_set_8[ps.name].id if ps.rank == 8 },
    { for ps in local.network_access_policy_sets : ps.name => ise_network_access_policy_set.network_access_policy_set_9[ps.name].id if ps.rank == 9 },
    { for ps in local.network_access_policy_sets : ps.name => ise_network_access_policy_set.network_access_policy_set_10[ps.name].id if ps.rank == 10 },
    { for ps in local.network_access_policy_sets : ps.name => ise_network_access_policy_set.network_access_policy_set_11[ps.name].id if ps.rank == 11 },
    { for ps in local.network_access_policy_sets : ps.name => ise_network_access_policy_set.network_access_policy_set_12[ps.name].id if ps.rank == 12 },
    { for ps in local.network_access_policy_sets : ps.name => ise_network_access_policy_set.network_access_policy_set_13[ps.name].id if ps.rank == 13 },
    { for ps in local.network_access_policy_sets : ps.name => ise_network_access_policy_set.network_access_policy_set_14[ps.name].id if ps.rank == 14 },
    { for ps in local.network_access_policy_sets : ps.name => ise_network_access_policy_set.network_access_policy_set_15[ps.name].id if ps.rank == 15 },
    { for ps in local.network_access_policy_sets : ps.name => ise_network_access_policy_set.network_access_policy_set_16[ps.name].id if ps.rank == 16 },
    { for ps in local.network_access_policy_sets : ps.name => ise_network_access_policy_set.network_access_policy_set_17[ps.name].id if ps.rank == 17 },
    { for ps in local.network_access_policy_sets : ps.name => ise_network_access_policy_set.network_access_policy_set_18[ps.name].id if ps.rank == 18 },
    { for ps in local.network_access_policy_sets : ps.name => ise_network_access_policy_set.network_access_policy_set_19[ps.name].id if ps.rank == 19 },
  )

  network_access_authentication_rules = flatten([
    for ps in try(local.ise.network_access.policy_sets, []) : [
      for rule in try(ps.authentication_rules, []) : {
        key                        = format("%s/%s", ps.name, rule.name)
        policy_set_id              = local.network_access_policy_set_ids[ps.name]
        name                       = rule.name
        rank                       = try(rule.rank, local.defaults.ise.network_access.policy_sets.authentication_rules.rank, null)
        default                    = try(rule.default, local.defaults.ise.network_access.policy_sets.authentication_rules.default, null)
        state                      = try(rule.state, local.defaults.ise.network_access.policy_sets.authentication_rules.state, null)
        condition_type             = try(rule.condition.type, local.defaults.ise.network_access.policy_sets.authentication_rules.condition.type, null)
        condition_id               = contains(local.known_conditions_network_access, try(rule.condition.name, "")) ? ise_network_access_condition.network_access_condition[rule.condition.name].id : try(data.ise_network_access_condition.network_access_condition[rule.condition.name].id, null)
        condition_is_negate        = try(rule.condition.is_negate, local.defaults.ise.network_access.policy_sets.authentication_rules.condition.is_negate, null)
        condition_attribute_name   = try(rule.condition.attribute_name, local.defaults.ise.network_access.policy_sets.authentication_rules.condition.attribute_name, null)
        condition_attribute_value  = try(rule.condition.attribute_value, local.defaults.ise.network_access.policy_sets.authentication_rules.condition.attribute_value, null)
        condition_dictionary_name  = try(rule.condition.dictionary_name, local.defaults.ise.network_access.policy_sets.authentication_rules.condition.dictionary_name, null)
        condition_dictionary_value = try(rule.condition.dictionary_value, local.defaults.ise.network_access.policy_sets.authentication_rules.condition.dictionary_value, null)
        condition_operator         = try(rule.condition.operator, local.defaults.ise.network_access.policy_sets.authentication_rules.condition.operator, null)
        identity_source_name       = try(rule.identity_source_name, local.defaults.ise.network_access.policy_sets.authentication_rules.identity_source_name, null)
        if_auth_fail               = try(rule.if_auth_fail, local.defaults.ise.network_access.policy_sets.authentication_rules.if_auth_fail, null)
        if_process_fail            = try(rule.if_process_fail, local.defaults.ise.network_access.policy_sets.authentication_rules.if_process_fail, null)
        if_user_not_found          = try(rule.if_user_not_found, local.defaults.ise.network_access.policy_sets.authentication_rules.if_user_not_found, null)
        children = try([for i in rule.condition.children : {
          attribute_name   = try(i.attribute_name, local.defaults.ise.network_access.policy_sets.authentication_rules.condition.attribute_name, null)
          attribute_value  = try(i.attribute_value, local.defaults.ise.network_access.policy_sets.authentication_rules.condition.attribute_value, null)
          dictionary_name  = try(i.dictionary_name, local.defaults.ise.network_access.policy_sets.authentication_rules.condition.dictionary_name, null)
          dictionary_value = try(i.dictionary_value, local.defaults.ise.network_access.policy_sets.authentication_rules.condition.dictionary_value, null)
          condition_type   = try(i.type, local.defaults.ise.network_access.policy_sets.authentication_rules.condition.type, null)
          is_negate        = try(i.is_negate, local.defaults.ise.network_access.policy_sets.authentication_rules.condition.is_negate, null)
          operator         = try(i.operator, local.defaults.ise.network_access.policy_sets.authentication_rules.condition.operator, null)
          id               = contains(local.known_conditions_network_access, try(i.name, "")) ? ise_network_access_condition.network_access_condition[i.name].id : try(data.ise_network_access_condition.network_access_condition[i.name].id, null)
          children = try([for j in i.children : {
            attribute_name   = try(j.attribute_name, local.defaults.ise.network_access.policy_sets.authentication_rules.condition.attribute_name, null)
            attribute_value  = try(j.attribute_value, local.defaults.ise.network_access.policy_sets.authentication_rules.condition.attribute_value, null)
            dictionary_name  = try(j.dictionary_name, local.defaults.ise.network_access.policy_sets.authentication_rules.condition.dictionary_name, null)
            dictionary_value = try(j.dictionary_value, local.defaults.ise.network_access.policy_sets.authentication_rules.condition.dictionary_value, null)
            condition_type   = try(j.type, local.defaults.ise.network_access.policy_sets.authentication_rules.condition.type, null)
            is_negate        = try(j.is_negate, local.defaults.ise.network_access.policy_sets.authentication_rules.condition.is_negate, null)
            operator         = try(j.operator, local.defaults.ise.network_access.policy_sets.authentication_rules.condition.operator, null)
            id               = contains(local.known_conditions_network_access, try(j.name, "")) ? ise_network_access_condition.network_access_condition[j.name].id : try(data.ise_network_access_condition.network_access_condition[j.name].id, null)
          }], null)
        }], null)
      }
    ]
  ])
}

resource "ise_network_access_authentication_rule" "network_access_authentication_rule_0" {
  for_each = { for rule in local.network_access_authentication_rules : rule.key => rule if(rule.rank == 0 || rule.rank == null) }

  policy_set_id             = each.value.policy_set_id
  name                      = each.value.name
  rank                      = each.value.rank
  default                   = each.value.default
  state                     = each.value.state
  condition_type            = each.value.condition_type
  condition_id              = each.value.condition_id
  condition_is_negate       = each.value.condition_is_negate
  condition_attribute_name  = each.value.condition_attribute_name
  condition_attribute_value = each.value.condition_attribute_value
  condition_dictionary_name = each.value.condition_dictionary_name
  condition_operator        = each.value.condition_operator
  identity_source_name      = each.value.identity_source_name
  if_auth_fail              = each.value.if_auth_fail
  if_process_fail           = each.value.if_process_fail
  if_user_not_found         = each.value.if_user_not_found
  children                  = each.value.children

  depends_on = [ise_active_directory_add_groups.active_directory_groups]
}

resource "ise_network_access_authentication_rule" "network_access_authentication_rule_1" {
  for_each = { for rule in local.network_access_authentication_rules : rule.key => rule if rule.rank == 1 }

  policy_set_id             = each.value.policy_set_id
  name                      = each.value.name
  rank                      = each.value.rank
  default                   = each.value.default
  state                     = each.value.state
  condition_type            = each.value.condition_type
  condition_id              = each.value.condition_id
  condition_is_negate       = each.value.condition_is_negate
  condition_attribute_name  = each.value.condition_attribute_name
  condition_attribute_value = each.value.condition_attribute_value
  condition_dictionary_name = each.value.condition_dictionary_name
  condition_operator        = each.value.condition_operator
  identity_source_name      = each.value.identity_source_name
  if_auth_fail              = each.value.if_auth_fail
  if_process_fail           = each.value.if_process_fail
  if_user_not_found         = each.value.if_user_not_found
  children                  = each.value.children

  depends_on = [ise_network_access_authentication_rule.network_access_authentication_rule_0, ise_active_directory_add_groups.active_directory_groups]
}

resource "ise_network_access_authentication_rule" "network_access_authentication_rule_2" {
  for_each = { for rule in local.network_access_authentication_rules : rule.key => rule if rule.rank == 2 }

  policy_set_id             = each.value.policy_set_id
  name                      = each.value.name
  rank                      = each.value.rank
  default                   = each.value.default
  state                     = each.value.state
  condition_type            = each.value.condition_type
  condition_id              = each.value.condition_id
  condition_is_negate       = each.value.condition_is_negate
  condition_attribute_name  = each.value.condition_attribute_name
  condition_attribute_value = each.value.condition_attribute_value
  condition_dictionary_name = each.value.condition_dictionary_name
  condition_operator        = each.value.condition_operator
  identity_source_name      = each.value.identity_source_name
  if_auth_fail              = each.value.if_auth_fail
  if_process_fail           = each.value.if_process_fail
  if_user_not_found         = each.value.if_user_not_found
  children                  = each.value.children

  depends_on = [ise_network_access_authentication_rule.network_access_authentication_rule_1, ise_active_directory_add_groups.active_directory_groups]
}

resource "ise_network_access_authentication_rule" "network_access_authentication_rule_3" {
  for_each = { for rule in local.network_access_authentication_rules : rule.key => rule if rule.rank == 3 }

  policy_set_id             = each.value.policy_set_id
  name                      = each.value.name
  rank                      = each.value.rank
  default                   = each.value.default
  state                     = each.value.state
  condition_type            = each.value.condition_type
  condition_id              = each.value.condition_id
  condition_is_negate       = each.value.condition_is_negate
  condition_attribute_name  = each.value.condition_attribute_name
  condition_attribute_value = each.value.condition_attribute_value
  condition_dictionary_name = each.value.condition_dictionary_name
  condition_operator        = each.value.condition_operator
  identity_source_name      = each.value.identity_source_name
  if_auth_fail              = each.value.if_auth_fail
  if_process_fail           = each.value.if_process_fail
  if_user_not_found         = each.value.if_user_not_found
  children                  = each.value.children

  depends_on = [ise_network_access_authentication_rule.network_access_authentication_rule_2, ise_active_directory_add_groups.active_directory_groups]
}

resource "ise_network_access_authentication_rule" "network_access_authentication_rule_4" {
  for_each = { for rule in local.network_access_authentication_rules : rule.key => rule if rule.rank == 4 }

  policy_set_id             = each.value.policy_set_id
  name                      = each.value.name
  rank                      = each.value.rank
  default                   = each.value.default
  state                     = each.value.state
  condition_type            = each.value.condition_type
  condition_id              = each.value.condition_id
  condition_is_negate       = each.value.condition_is_negate
  condition_attribute_name  = each.value.condition_attribute_name
  condition_attribute_value = each.value.condition_attribute_value
  condition_dictionary_name = each.value.condition_dictionary_name
  condition_operator        = each.value.condition_operator
  identity_source_name      = each.value.identity_source_name
  if_auth_fail              = each.value.if_auth_fail
  if_process_fail           = each.value.if_process_fail
  if_user_not_found         = each.value.if_user_not_found
  children                  = each.value.children

  depends_on = [ise_network_access_authentication_rule.network_access_authentication_rule_3, ise_active_directory_add_groups.active_directory_groups]
}

resource "ise_network_access_authentication_rule" "network_access_authentication_rule_5" {
  for_each = { for rule in local.network_access_authentication_rules : rule.key => rule if rule.rank == 5 }

  policy_set_id             = each.value.policy_set_id
  name                      = each.value.name
  rank                      = each.value.rank
  default                   = each.value.default
  state                     = each.value.state
  condition_type            = each.value.condition_type
  condition_id              = each.value.condition_id
  condition_is_negate       = each.value.condition_is_negate
  condition_attribute_name  = each.value.condition_attribute_name
  condition_attribute_value = each.value.condition_attribute_value
  condition_dictionary_name = each.value.condition_dictionary_name
  condition_operator        = each.value.condition_operator
  identity_source_name      = each.value.identity_source_name
  if_auth_fail              = each.value.if_auth_fail
  if_process_fail           = each.value.if_process_fail
  if_user_not_found         = each.value.if_user_not_found
  children                  = each.value.children

  depends_on = [ise_network_access_authentication_rule.network_access_authentication_rule_4, ise_active_directory_add_groups.active_directory_groups]
}

resource "ise_network_access_authentication_rule" "network_access_authentication_rule_6" {
  for_each = { for rule in local.network_access_authentication_rules : rule.key => rule if rule.rank == 6 }

  policy_set_id             = each.value.policy_set_id
  name                      = each.value.name
  rank                      = each.value.rank
  default                   = each.value.default
  state                     = each.value.state
  condition_type            = each.value.condition_type
  condition_id              = each.value.condition_id
  condition_is_negate       = each.value.condition_is_negate
  condition_attribute_name  = each.value.condition_attribute_name
  condition_attribute_value = each.value.condition_attribute_value
  condition_dictionary_name = each.value.condition_dictionary_name
  condition_operator        = each.value.condition_operator
  identity_source_name      = each.value.identity_source_name
  if_auth_fail              = each.value.if_auth_fail
  if_process_fail           = each.value.if_process_fail
  if_user_not_found         = each.value.if_user_not_found
  children                  = each.value.children

  depends_on = [ise_network_access_authentication_rule.network_access_authentication_rule_5, ise_active_directory_add_groups.active_directory_groups]
}

resource "ise_network_access_authentication_rule" "network_access_authentication_rule_7" {
  for_each = { for rule in local.network_access_authentication_rules : rule.key => rule if rule.rank == 7 }

  policy_set_id             = each.value.policy_set_id
  name                      = each.value.name
  rank                      = each.value.rank
  default                   = each.value.default
  state                     = each.value.state
  condition_type            = each.value.condition_type
  condition_id              = each.value.condition_id
  condition_is_negate       = each.value.condition_is_negate
  condition_attribute_name  = each.value.condition_attribute_name
  condition_attribute_value = each.value.condition_attribute_value
  condition_dictionary_name = each.value.condition_dictionary_name
  condition_operator        = each.value.condition_operator
  identity_source_name      = each.value.identity_source_name
  if_auth_fail              = each.value.if_auth_fail
  if_process_fail           = each.value.if_process_fail
  if_user_not_found         = each.value.if_user_not_found
  children                  = each.value.children

  depends_on = [ise_network_access_authentication_rule.network_access_authentication_rule_6, ise_active_directory_add_groups.active_directory_groups]
}

resource "ise_network_access_authentication_rule" "network_access_authentication_rule_8" {
  for_each = { for rule in local.network_access_authentication_rules : rule.key => rule if rule.rank == 8 }

  policy_set_id             = each.value.policy_set_id
  name                      = each.value.name
  rank                      = each.value.rank
  default                   = each.value.default
  state                     = each.value.state
  condition_type            = each.value.condition_type
  condition_id              = each.value.condition_id
  condition_is_negate       = each.value.condition_is_negate
  condition_attribute_name  = each.value.condition_attribute_name
  condition_attribute_value = each.value.condition_attribute_value
  condition_dictionary_name = each.value.condition_dictionary_name
  condition_operator        = each.value.condition_operator
  identity_source_name      = each.value.identity_source_name
  if_auth_fail              = each.value.if_auth_fail
  if_process_fail           = each.value.if_process_fail
  if_user_not_found         = each.value.if_user_not_found
  children                  = each.value.children

  depends_on = [ise_network_access_authentication_rule.network_access_authentication_rule_7, ise_active_directory_add_groups.active_directory_groups]
}

resource "ise_network_access_authentication_rule" "network_access_authentication_rule_9" {
  for_each = { for rule in local.network_access_authentication_rules : rule.key => rule if rule.rank == 9 }

  policy_set_id             = each.value.policy_set_id
  name                      = each.value.name
  rank                      = each.value.rank
  default                   = each.value.default
  state                     = each.value.state
  condition_type            = each.value.condition_type
  condition_id              = each.value.condition_id
  condition_is_negate       = each.value.condition_is_negate
  condition_attribute_name  = each.value.condition_attribute_name
  condition_attribute_value = each.value.condition_attribute_value
  condition_dictionary_name = each.value.condition_dictionary_name
  condition_operator        = each.value.condition_operator
  identity_source_name      = each.value.identity_source_name
  if_auth_fail              = each.value.if_auth_fail
  if_process_fail           = each.value.if_process_fail
  if_user_not_found         = each.value.if_user_not_found
  children                  = each.value.children

  depends_on = [ise_network_access_authentication_rule.network_access_authentication_rule_8, ise_active_directory_add_groups.active_directory_groups]
}

resource "ise_network_access_authentication_rule" "network_access_authentication_rule_10" {
  for_each = { for rule in local.network_access_authentication_rules : rule.key => rule if rule.rank == 10 }

  policy_set_id             = each.value.policy_set_id
  name                      = each.value.name
  rank                      = each.value.rank
  default                   = each.value.default
  state                     = each.value.state
  condition_type            = each.value.condition_type
  condition_id              = each.value.condition_id
  condition_is_negate       = each.value.condition_is_negate
  condition_attribute_name  = each.value.condition_attribute_name
  condition_attribute_value = each.value.condition_attribute_value
  condition_dictionary_name = each.value.condition_dictionary_name
  condition_operator        = each.value.condition_operator
  identity_source_name      = each.value.identity_source_name
  if_auth_fail              = each.value.if_auth_fail
  if_process_fail           = each.value.if_process_fail
  if_user_not_found         = each.value.if_user_not_found
  children                  = each.value.children

  depends_on = [ise_network_access_authentication_rule.network_access_authentication_rule_9, ise_active_directory_add_groups.active_directory_groups]
}

resource "ise_network_access_authentication_rule" "network_access_authentication_rule_11" {
  for_each = { for rule in local.network_access_authentication_rules : rule.key => rule if rule.rank == 11 }

  policy_set_id             = each.value.policy_set_id
  name                      = each.value.name
  rank                      = each.value.rank
  default                   = each.value.default
  state                     = each.value.state
  condition_type            = each.value.condition_type
  condition_id              = each.value.condition_id
  condition_is_negate       = each.value.condition_is_negate
  condition_attribute_name  = each.value.condition_attribute_name
  condition_attribute_value = each.value.condition_attribute_value
  condition_dictionary_name = each.value.condition_dictionary_name
  condition_operator        = each.value.condition_operator
  identity_source_name      = each.value.identity_source_name
  if_auth_fail              = each.value.if_auth_fail
  if_process_fail           = each.value.if_process_fail
  if_user_not_found         = each.value.if_user_not_found
  children                  = each.value.children

  depends_on = [ise_network_access_authentication_rule.network_access_authentication_rule_10, ise_active_directory_add_groups.active_directory_groups]
}

resource "ise_network_access_authentication_rule" "network_access_authentication_rule_12" {
  for_each = { for rule in local.network_access_authentication_rules : rule.key => rule if rule.rank == 12 }

  policy_set_id             = each.value.policy_set_id
  name                      = each.value.name
  rank                      = each.value.rank
  default                   = each.value.default
  state                     = each.value.state
  condition_type            = each.value.condition_type
  condition_id              = each.value.condition_id
  condition_is_negate       = each.value.condition_is_negate
  condition_attribute_name  = each.value.condition_attribute_name
  condition_attribute_value = each.value.condition_attribute_value
  condition_dictionary_name = each.value.condition_dictionary_name
  condition_operator        = each.value.condition_operator
  identity_source_name      = each.value.identity_source_name
  if_auth_fail              = each.value.if_auth_fail
  if_process_fail           = each.value.if_process_fail
  if_user_not_found         = each.value.if_user_not_found
  children                  = each.value.children

  depends_on = [ise_network_access_authentication_rule.network_access_authentication_rule_11, ise_active_directory_add_groups.active_directory_groups]
}

resource "ise_network_access_authentication_rule" "network_access_authentication_rule_13" {
  for_each = { for rule in local.network_access_authentication_rules : rule.key => rule if rule.rank == 13 }

  policy_set_id             = each.value.policy_set_id
  name                      = each.value.name
  rank                      = each.value.rank
  default                   = each.value.default
  state                     = each.value.state
  condition_type            = each.value.condition_type
  condition_id              = each.value.condition_id
  condition_is_negate       = each.value.condition_is_negate
  condition_attribute_name  = each.value.condition_attribute_name
  condition_attribute_value = each.value.condition_attribute_value
  condition_dictionary_name = each.value.condition_dictionary_name
  condition_operator        = each.value.condition_operator
  identity_source_name      = each.value.identity_source_name
  if_auth_fail              = each.value.if_auth_fail
  if_process_fail           = each.value.if_process_fail
  if_user_not_found         = each.value.if_user_not_found
  children                  = each.value.children

  depends_on = [ise_network_access_authentication_rule.network_access_authentication_rule_12, ise_active_directory_add_groups.active_directory_groups]
}

resource "ise_network_access_authentication_rule" "network_access_authentication_rule_14" {
  for_each = { for rule in local.network_access_authentication_rules : rule.key => rule if rule.rank == 14 }

  policy_set_id             = each.value.policy_set_id
  name                      = each.value.name
  rank                      = each.value.rank
  default                   = each.value.default
  state                     = each.value.state
  condition_type            = each.value.condition_type
  condition_id              = each.value.condition_id
  condition_is_negate       = each.value.condition_is_negate
  condition_attribute_name  = each.value.condition_attribute_name
  condition_attribute_value = each.value.condition_attribute_value
  condition_dictionary_name = each.value.condition_dictionary_name
  condition_operator        = each.value.condition_operator
  identity_source_name      = each.value.identity_source_name
  if_auth_fail              = each.value.if_auth_fail
  if_process_fail           = each.value.if_process_fail
  if_user_not_found         = each.value.if_user_not_found
  children                  = each.value.children

  depends_on = [ise_network_access_authentication_rule.network_access_authentication_rule_13, ise_active_directory_add_groups.active_directory_groups]
}

resource "ise_network_access_authentication_rule" "network_access_authentication_rule_15" {
  for_each = { for rule in local.network_access_authentication_rules : rule.key => rule if rule.rank == 15 }

  policy_set_id             = each.value.policy_set_id
  name                      = each.value.name
  rank                      = each.value.rank
  default                   = each.value.default
  state                     = each.value.state
  condition_type            = each.value.condition_type
  condition_id              = each.value.condition_id
  condition_is_negate       = each.value.condition_is_negate
  condition_attribute_name  = each.value.condition_attribute_name
  condition_attribute_value = each.value.condition_attribute_value
  condition_dictionary_name = each.value.condition_dictionary_name
  condition_operator        = each.value.condition_operator
  identity_source_name      = each.value.identity_source_name
  if_auth_fail              = each.value.if_auth_fail
  if_process_fail           = each.value.if_process_fail
  if_user_not_found         = each.value.if_user_not_found
  children                  = each.value.children

  depends_on = [ise_network_access_authentication_rule.network_access_authentication_rule_14, ise_active_directory_add_groups.active_directory_groups]
}

resource "ise_network_access_authentication_rule" "network_access_authentication_rule_16" {
  for_each = { for rule in local.network_access_authentication_rules : rule.key => rule if rule.rank == 16 }

  policy_set_id             = each.value.policy_set_id
  name                      = each.value.name
  rank                      = each.value.rank
  default                   = each.value.default
  state                     = each.value.state
  condition_type            = each.value.condition_type
  condition_id              = each.value.condition_id
  condition_is_negate       = each.value.condition_is_negate
  condition_attribute_name  = each.value.condition_attribute_name
  condition_attribute_value = each.value.condition_attribute_value
  condition_dictionary_name = each.value.condition_dictionary_name
  condition_operator        = each.value.condition_operator
  identity_source_name      = each.value.identity_source_name
  if_auth_fail              = each.value.if_auth_fail
  if_process_fail           = each.value.if_process_fail
  if_user_not_found         = each.value.if_user_not_found
  children                  = each.value.children

  depends_on = [ise_network_access_authentication_rule.network_access_authentication_rule_15, ise_active_directory_add_groups.active_directory_groups]
}

resource "ise_network_access_authentication_rule" "network_access_authentication_rule_17" {
  for_each = { for rule in local.network_access_authentication_rules : rule.key => rule if rule.rank == 17 }

  policy_set_id             = each.value.policy_set_id
  name                      = each.value.name
  rank                      = each.value.rank
  default                   = each.value.default
  state                     = each.value.state
  condition_type            = each.value.condition_type
  condition_id              = each.value.condition_id
  condition_is_negate       = each.value.condition_is_negate
  condition_attribute_name  = each.value.condition_attribute_name
  condition_attribute_value = each.value.condition_attribute_value
  condition_dictionary_name = each.value.condition_dictionary_name
  condition_operator        = each.value.condition_operator
  identity_source_name      = each.value.identity_source_name
  if_auth_fail              = each.value.if_auth_fail
  if_process_fail           = each.value.if_process_fail
  if_user_not_found         = each.value.if_user_not_found
  children                  = each.value.children

  depends_on = [ise_network_access_authentication_rule.network_access_authentication_rule_16, ise_active_directory_add_groups.active_directory_groups]
}

resource "ise_network_access_authentication_rule" "network_access_authentication_rule_18" {
  for_each = { for rule in local.network_access_authentication_rules : rule.key => rule if rule.rank == 18 }

  policy_set_id             = each.value.policy_set_id
  name                      = each.value.name
  rank                      = each.value.rank
  default                   = each.value.default
  state                     = each.value.state
  condition_type            = each.value.condition_type
  condition_id              = each.value.condition_id
  condition_is_negate       = each.value.condition_is_negate
  condition_attribute_name  = each.value.condition_attribute_name
  condition_attribute_value = each.value.condition_attribute_value
  condition_dictionary_name = each.value.condition_dictionary_name
  condition_operator        = each.value.condition_operator
  identity_source_name      = each.value.identity_source_name
  if_auth_fail              = each.value.if_auth_fail
  if_process_fail           = each.value.if_process_fail
  if_user_not_found         = each.value.if_user_not_found
  children                  = each.value.children

  depends_on = [ise_network_access_authentication_rule.network_access_authentication_rule_17, ise_active_directory_add_groups.active_directory_groups]
}

resource "ise_network_access_authentication_rule" "network_access_authentication_rule_19" {
  for_each = { for rule in local.network_access_authentication_rules : rule.key => rule if rule.rank == 19 }

  policy_set_id             = each.value.policy_set_id
  name                      = each.value.name
  rank                      = each.value.rank
  default                   = each.value.default
  state                     = each.value.state
  condition_type            = each.value.condition_type
  condition_id              = each.value.condition_id
  condition_is_negate       = each.value.condition_is_negate
  condition_attribute_name  = each.value.condition_attribute_name
  condition_attribute_value = each.value.condition_attribute_value
  condition_dictionary_name = each.value.condition_dictionary_name
  condition_operator        = each.value.condition_operator
  identity_source_name      = each.value.identity_source_name
  if_auth_fail              = each.value.if_auth_fail
  if_process_fail           = each.value.if_process_fail
  if_user_not_found         = each.value.if_user_not_found
  children                  = each.value.children

  depends_on = [ise_network_access_authentication_rule.network_access_authentication_rule_18, ise_active_directory_add_groups.active_directory_groups]
}

locals {
  network_access_authorization_rules = flatten([
    for ps in try(local.ise.network_access.policy_sets, []) : [
      for rule in try(ps.authorization_rules, []) : {
        key                        = format("%s/%s", ps.name, rule.name)
        policy_set_id              = local.network_access_policy_set_ids[ps.name]
        name                       = rule.name
        rank                       = try(rule.rank, local.defaults.ise.network_access.policy_sets.authorization_rules.rank, null)
        default                    = try(rule.default, local.defaults.ise.network_access.policy_sets.authorization_rules.default, null)
        state                      = try(rule.state, local.defaults.ise.network_access.policy_sets.authorization_rules.state, null)
        condition_type             = try(rule.condition.type, local.defaults.ise.network_access.policy_sets.authorization_rules.condition.type, null)
        condition_id               = contains(local.known_conditions_network_access, try(rule.condition.name, "")) ? ise_network_access_condition.network_access_condition[rule.condition.name].id : try(data.ise_network_access_condition.network_access_condition[rule.condition.name].id, null)
        condition_is_negate        = try(rule.condition.is_negate, local.defaults.ise.network_access.policy_sets.authorization_rules.condition.is_negate, null)
        condition_attribute_name   = try(rule.condition.attribute_name, local.defaults.ise.network_access.policy_sets.authorization_rules.condition.attribute_name, null)
        condition_attribute_value  = try(rule.condition.attribute_value, local.defaults.ise.network_access.policy_sets.authorization_rules.condition.attribute_value, null)
        condition_dictionary_name  = try(rule.condition.dictionary_name, local.defaults.ise.network_access.policy_sets.authorization_rules.condition.dictionary_name, null)
        condition_dictionary_value = try(rule.condition.dictionary_value, local.defaults.ise.network_access.policy_sets.authorization_rules.condition.dictionary_value, null)
        condition_operator         = try(rule.condition.operator, local.defaults.ise.network_access.policy_sets.authorization_rules.condition.operator, null)
        profiles                   = try(rule.profiles, local.defaults.ise.network_access.policy_sets.authorization_rules.profiles, null)
        security_group             = try(rule.security_group, local.defaults.ise.network_access.policy_sets.authorization_rules.security_group, null)
        children = try([for i in rule.condition.children : {
          attribute_name   = try(i.attribute_name, local.defaults.ise.network_access.policy_sets.authorization_rules.condition.attribute_name, null)
          attribute_value  = try(i.attribute_value, local.defaults.ise.network_access.policy_sets.authorization_rules.condition.attribute_value, null)
          dictionary_name  = try(i.dictionary_name, local.defaults.ise.network_access.policy_sets.authorization_rules.condition.dictionary_name, null)
          dictionary_value = try(i.dictionary_value, local.defaults.ise.network_access.policy_sets.authorization_rules.condition.dictionary_value, null)
          condition_type   = try(i.type, local.defaults.ise.network_access.policy_sets.authorization_rules.condition.type, null)
          is_negate        = try(i.is_negate, local.defaults.ise.network_access.policy_sets.authorization_rules.condition.is_negate, null)
          operator         = try(i.operator, local.defaults.ise.network_access.policy_sets.authorization_rules.condition.operator, null)
          id               = contains(local.known_conditions_network_access, try(i.name, "")) ? ise_network_access_condition.network_access_condition[i.name].id : try(data.ise_network_access_condition.network_access_condition[i.name].id, null)
          children = try([for j in i.children : {
            attribute_name   = try(j.attribute_name, local.defaults.ise.network_access.policy_sets.authorization_rules.condition.attribute_name, null)
            attribute_value  = try(j.attribute_value, local.defaults.ise.network_access.policy_sets.authorization_rules.condition.attribute_value, null)
            dictionary_name  = try(j.dictionary_name, local.defaults.ise.network_access.policy_sets.authorization_rules.condition.dictionary_name, null)
            dictionary_value = try(j.dictionary_value, local.defaults.ise.network_access.policy_sets.authorization_rules.condition.dictionary_value, null)
            condition_type   = try(j.type, local.defaults.ise.network_access.policy_sets.authorization_rules.condition.type, null)
            is_negate        = try(j.is_negate, local.defaults.ise.network_access.policy_sets.authorization_rules.condition.is_negate, null)
            operator         = try(j.operator, local.defaults.ise.network_access.policy_sets.authorization_rules.condition.operator, null)
            id               = contains(local.known_conditions_network_access, try(j.name, "")) ? ise_network_access_condition.network_access_condition[j.name].id : try(data.ise_network_access_condition.network_access_condition[j.name].id, null)
          }], null)
        }], null)
      }
    ]
  ])
}

resource "ise_network_access_authorization_rule" "network_access_authorization_rule_0" {
  for_each = { for rule in local.network_access_authorization_rules : rule.key => rule if(rule.rank == 0 || rule.rank == null) }

  policy_set_id             = each.value.policy_set_id
  name                      = each.value.name
  rank                      = each.value.rank
  default                   = each.value.default
  state                     = each.value.state
  condition_type            = each.value.condition_type
  condition_id              = each.value.condition_id
  condition_is_negate       = each.value.condition_is_negate
  condition_attribute_name  = each.value.condition_attribute_name
  condition_attribute_value = each.value.condition_attribute_value
  condition_dictionary_name = each.value.condition_dictionary_name
  condition_operator        = each.value.condition_operator
  profiles                  = each.value.profiles
  security_group            = each.value.security_group
  children                  = each.value.children

  depends_on = [ise_authorization_profile.authorization_profile, ise_trustsec_security_group.trustsec_security_group, time_sleep.sgt_wait, ise_endpoint_identity_group.endpoint_identity_group, ise_user_identity_group.user_identity_group, ise_active_directory_add_groups.active_directory_groups]
}

resource "ise_network_access_authorization_rule" "network_access_authorization_rule_1" {
  for_each = { for rule in local.network_access_authorization_rules : rule.key => rule if rule.rank == 1 }

  policy_set_id             = each.value.policy_set_id
  name                      = each.value.name
  rank                      = each.value.rank
  default                   = each.value.default
  state                     = each.value.state
  condition_type            = each.value.condition_type
  condition_id              = each.value.condition_id
  condition_is_negate       = each.value.condition_is_negate
  condition_attribute_name  = each.value.condition_attribute_name
  condition_attribute_value = each.value.condition_attribute_value
  condition_dictionary_name = each.value.condition_dictionary_name
  condition_operator        = each.value.condition_operator
  profiles                  = each.value.profiles
  security_group            = each.value.security_group
  children                  = each.value.children

  depends_on = [ise_network_access_authorization_rule.network_access_authorization_rule_0, ise_active_directory_add_groups.active_directory_groups]
}

resource "ise_network_access_authorization_rule" "network_access_authorization_rule_2" {
  for_each = { for rule in local.network_access_authorization_rules : rule.key => rule if rule.rank == 2 }

  policy_set_id             = each.value.policy_set_id
  name                      = each.value.name
  rank                      = each.value.rank
  default                   = each.value.default
  state                     = each.value.state
  condition_type            = each.value.condition_type
  condition_id              = each.value.condition_id
  condition_is_negate       = each.value.condition_is_negate
  condition_attribute_name  = each.value.condition_attribute_name
  condition_attribute_value = each.value.condition_attribute_value
  condition_dictionary_name = each.value.condition_dictionary_name
  condition_operator        = each.value.condition_operator
  profiles                  = each.value.profiles
  security_group            = each.value.security_group
  children                  = each.value.children

  depends_on = [ise_network_access_authorization_rule.network_access_authorization_rule_1, ise_active_directory_add_groups.active_directory_groups]
}

resource "ise_network_access_authorization_rule" "network_access_authorization_rule_3" {
  for_each = { for rule in local.network_access_authorization_rules : rule.key => rule if rule.rank == 3 }

  policy_set_id             = each.value.policy_set_id
  name                      = each.value.name
  rank                      = each.value.rank
  default                   = each.value.default
  state                     = each.value.state
  condition_type            = each.value.condition_type
  condition_id              = each.value.condition_id
  condition_is_negate       = each.value.condition_is_negate
  condition_attribute_name  = each.value.condition_attribute_name
  condition_attribute_value = each.value.condition_attribute_value
  condition_dictionary_name = each.value.condition_dictionary_name
  condition_operator        = each.value.condition_operator
  profiles                  = each.value.profiles
  security_group            = each.value.security_group
  children                  = each.value.children

  depends_on = [ise_network_access_authorization_rule.network_access_authorization_rule_2, ise_active_directory_add_groups.active_directory_groups]
}

resource "ise_network_access_authorization_rule" "network_access_authorization_rule_4" {
  for_each = { for rule in local.network_access_authorization_rules : rule.key => rule if rule.rank == 4 }

  policy_set_id             = each.value.policy_set_id
  name                      = each.value.name
  rank                      = each.value.rank
  default                   = each.value.default
  state                     = each.value.state
  condition_type            = each.value.condition_type
  condition_id              = each.value.condition_id
  condition_is_negate       = each.value.condition_is_negate
  condition_attribute_name  = each.value.condition_attribute_name
  condition_attribute_value = each.value.condition_attribute_value
  condition_dictionary_name = each.value.condition_dictionary_name
  condition_operator        = each.value.condition_operator
  profiles                  = each.value.profiles
  security_group            = each.value.security_group
  children                  = each.value.children

  depends_on = [ise_network_access_authorization_rule.network_access_authorization_rule_3, ise_active_directory_add_groups.active_directory_groups]
}

resource "ise_network_access_authorization_rule" "network_access_authorization_rule_5" {
  for_each = { for rule in local.network_access_authorization_rules : rule.key => rule if rule.rank == 5 }

  policy_set_id             = each.value.policy_set_id
  name                      = each.value.name
  rank                      = each.value.rank
  default                   = each.value.default
  state                     = each.value.state
  condition_type            = each.value.condition_type
  condition_id              = each.value.condition_id
  condition_is_negate       = each.value.condition_is_negate
  condition_attribute_name  = each.value.condition_attribute_name
  condition_attribute_value = each.value.condition_attribute_value
  condition_dictionary_name = each.value.condition_dictionary_name
  condition_operator        = each.value.condition_operator
  profiles                  = each.value.profiles
  security_group            = each.value.security_group
  children                  = each.value.children

  depends_on = [ise_network_access_authorization_rule.network_access_authorization_rule_4, ise_active_directory_add_groups.active_directory_groups]
}

resource "ise_network_access_authorization_rule" "network_access_authorization_rule_6" {
  for_each = { for rule in local.network_access_authorization_rules : rule.key => rule if rule.rank == 6 }

  policy_set_id             = each.value.policy_set_id
  name                      = each.value.name
  rank                      = each.value.rank
  default                   = each.value.default
  state                     = each.value.state
  condition_type            = each.value.condition_type
  condition_id              = each.value.condition_id
  condition_is_negate       = each.value.condition_is_negate
  condition_attribute_name  = each.value.condition_attribute_name
  condition_attribute_value = each.value.condition_attribute_value
  condition_dictionary_name = each.value.condition_dictionary_name
  condition_operator        = each.value.condition_operator
  profiles                  = each.value.profiles
  security_group            = each.value.security_group
  children                  = each.value.children

  depends_on = [ise_network_access_authorization_rule.network_access_authorization_rule_5, ise_active_directory_add_groups.active_directory_groups]
}

resource "ise_network_access_authorization_rule" "network_access_authorization_rule_7" {
  for_each = { for rule in local.network_access_authorization_rules : rule.key => rule if rule.rank == 7 }

  policy_set_id             = each.value.policy_set_id
  name                      = each.value.name
  rank                      = each.value.rank
  default                   = each.value.default
  state                     = each.value.state
  condition_type            = each.value.condition_type
  condition_id              = each.value.condition_id
  condition_is_negate       = each.value.condition_is_negate
  condition_attribute_name  = each.value.condition_attribute_name
  condition_attribute_value = each.value.condition_attribute_value
  condition_dictionary_name = each.value.condition_dictionary_name
  condition_operator        = each.value.condition_operator
  profiles                  = each.value.profiles
  security_group            = each.value.security_group
  children                  = each.value.children

  depends_on = [ise_network_access_authorization_rule.network_access_authorization_rule_6, ise_active_directory_add_groups.active_directory_groups]
}

resource "ise_network_access_authorization_rule" "network_access_authorization_rule_8" {
  for_each = { for rule in local.network_access_authorization_rules : rule.key => rule if rule.rank == 8 }

  policy_set_id             = each.value.policy_set_id
  name                      = each.value.name
  rank                      = each.value.rank
  default                   = each.value.default
  state                     = each.value.state
  condition_type            = each.value.condition_type
  condition_id              = each.value.condition_id
  condition_is_negate       = each.value.condition_is_negate
  condition_attribute_name  = each.value.condition_attribute_name
  condition_attribute_value = each.value.condition_attribute_value
  condition_dictionary_name = each.value.condition_dictionary_name
  condition_operator        = each.value.condition_operator
  profiles                  = each.value.profiles
  security_group            = each.value.security_group
  children                  = each.value.children

  depends_on = [ise_network_access_authorization_rule.network_access_authorization_rule_7, ise_active_directory_add_groups.active_directory_groups]
}

resource "ise_network_access_authorization_rule" "network_access_authorization_rule_9" {
  for_each = { for rule in local.network_access_authorization_rules : rule.key => rule if rule.rank == 9 }

  policy_set_id             = each.value.policy_set_id
  name                      = each.value.name
  rank                      = each.value.rank
  default                   = each.value.default
  state                     = each.value.state
  condition_type            = each.value.condition_type
  condition_id              = each.value.condition_id
  condition_is_negate       = each.value.condition_is_negate
  condition_attribute_name  = each.value.condition_attribute_name
  condition_attribute_value = each.value.condition_attribute_value
  condition_dictionary_name = each.value.condition_dictionary_name
  condition_operator        = each.value.condition_operator
  profiles                  = each.value.profiles
  security_group            = each.value.security_group
  children                  = each.value.children

  depends_on = [ise_network_access_authorization_rule.network_access_authorization_rule_8, ise_active_directory_add_groups.active_directory_groups]
}

resource "ise_network_access_authorization_rule" "network_access_authorization_rule_10" {
  for_each = { for rule in local.network_access_authorization_rules : rule.key => rule if rule.rank == 10 }

  policy_set_id             = each.value.policy_set_id
  name                      = each.value.name
  rank                      = each.value.rank
  default                   = each.value.default
  state                     = each.value.state
  condition_type            = each.value.condition_type
  condition_id              = each.value.condition_id
  condition_is_negate       = each.value.condition_is_negate
  condition_attribute_name  = each.value.condition_attribute_name
  condition_attribute_value = each.value.condition_attribute_value
  condition_dictionary_name = each.value.condition_dictionary_name
  condition_operator        = each.value.condition_operator
  profiles                  = each.value.profiles
  security_group            = each.value.security_group
  children                  = each.value.children

  depends_on = [ise_network_access_authorization_rule.network_access_authorization_rule_9, ise_active_directory_add_groups.active_directory_groups]
}

resource "ise_network_access_authorization_rule" "network_access_authorization_rule_11" {
  for_each = { for rule in local.network_access_authorization_rules : rule.key => rule if rule.rank == 11 }

  policy_set_id             = each.value.policy_set_id
  name                      = each.value.name
  rank                      = each.value.rank
  default                   = each.value.default
  state                     = each.value.state
  condition_type            = each.value.condition_type
  condition_id              = each.value.condition_id
  condition_is_negate       = each.value.condition_is_negate
  condition_attribute_name  = each.value.condition_attribute_name
  condition_attribute_value = each.value.condition_attribute_value
  condition_dictionary_name = each.value.condition_dictionary_name
  condition_operator        = each.value.condition_operator
  profiles                  = each.value.profiles
  security_group            = each.value.security_group
  children                  = each.value.children

  depends_on = [ise_network_access_authorization_rule.network_access_authorization_rule_10, ise_active_directory_add_groups.active_directory_groups]
}

resource "ise_network_access_authorization_rule" "network_access_authorization_rule_12" {
  for_each = { for rule in local.network_access_authorization_rules : rule.key => rule if rule.rank == 12 }

  policy_set_id             = each.value.policy_set_id
  name                      = each.value.name
  rank                      = each.value.rank
  default                   = each.value.default
  state                     = each.value.state
  condition_type            = each.value.condition_type
  condition_id              = each.value.condition_id
  condition_is_negate       = each.value.condition_is_negate
  condition_attribute_name  = each.value.condition_attribute_name
  condition_attribute_value = each.value.condition_attribute_value
  condition_dictionary_name = each.value.condition_dictionary_name
  condition_operator        = each.value.condition_operator
  profiles                  = each.value.profiles
  security_group            = each.value.security_group
  children                  = each.value.children

  depends_on = [ise_network_access_authorization_rule.network_access_authorization_rule_11, ise_active_directory_add_groups.active_directory_groups]
}

resource "ise_network_access_authorization_rule" "network_access_authorization_rule_13" {
  for_each = { for rule in local.network_access_authorization_rules : rule.key => rule if rule.rank == 13 }

  policy_set_id             = each.value.policy_set_id
  name                      = each.value.name
  rank                      = each.value.rank
  default                   = each.value.default
  state                     = each.value.state
  condition_type            = each.value.condition_type
  condition_id              = each.value.condition_id
  condition_is_negate       = each.value.condition_is_negate
  condition_attribute_name  = each.value.condition_attribute_name
  condition_attribute_value = each.value.condition_attribute_value
  condition_dictionary_name = each.value.condition_dictionary_name
  condition_operator        = each.value.condition_operator
  profiles                  = each.value.profiles
  security_group            = each.value.security_group
  children                  = each.value.children

  depends_on = [ise_network_access_authorization_rule.network_access_authorization_rule_12, ise_active_directory_add_groups.active_directory_groups]
}

resource "ise_network_access_authorization_rule" "network_access_authorization_rule_14" {
  for_each = { for rule in local.network_access_authorization_rules : rule.key => rule if rule.rank == 14 }

  policy_set_id             = each.value.policy_set_id
  name                      = each.value.name
  rank                      = each.value.rank
  default                   = each.value.default
  state                     = each.value.state
  condition_type            = each.value.condition_type
  condition_id              = each.value.condition_id
  condition_is_negate       = each.value.condition_is_negate
  condition_attribute_name  = each.value.condition_attribute_name
  condition_attribute_value = each.value.condition_attribute_value
  condition_dictionary_name = each.value.condition_dictionary_name
  condition_operator        = each.value.condition_operator
  profiles                  = each.value.profiles
  security_group            = each.value.security_group
  children                  = each.value.children

  depends_on = [ise_network_access_authorization_rule.network_access_authorization_rule_13, ise_active_directory_add_groups.active_directory_groups]
}

resource "ise_network_access_authorization_rule" "network_access_authorization_rule_15" {
  for_each = { for rule in local.network_access_authorization_rules : rule.key => rule if rule.rank == 15 }

  policy_set_id             = each.value.policy_set_id
  name                      = each.value.name
  rank                      = each.value.rank
  default                   = each.value.default
  state                     = each.value.state
  condition_type            = each.value.condition_type
  condition_id              = each.value.condition_id
  condition_is_negate       = each.value.condition_is_negate
  condition_attribute_name  = each.value.condition_attribute_name
  condition_attribute_value = each.value.condition_attribute_value
  condition_dictionary_name = each.value.condition_dictionary_name
  condition_operator        = each.value.condition_operator
  profiles                  = each.value.profiles
  security_group            = each.value.security_group
  children                  = each.value.children

  depends_on = [ise_network_access_authorization_rule.network_access_authorization_rule_14, ise_active_directory_add_groups.active_directory_groups]
}

resource "ise_network_access_authorization_rule" "network_access_authorization_rule_16" {
  for_each = { for rule in local.network_access_authorization_rules : rule.key => rule if rule.rank == 16 }

  policy_set_id             = each.value.policy_set_id
  name                      = each.value.name
  rank                      = each.value.rank
  default                   = each.value.default
  state                     = each.value.state
  condition_type            = each.value.condition_type
  condition_id              = each.value.condition_id
  condition_is_negate       = each.value.condition_is_negate
  condition_attribute_name  = each.value.condition_attribute_name
  condition_attribute_value = each.value.condition_attribute_value
  condition_dictionary_name = each.value.condition_dictionary_name
  condition_operator        = each.value.condition_operator
  profiles                  = each.value.profiles
  security_group            = each.value.security_group
  children                  = each.value.children

  depends_on = [ise_network_access_authorization_rule.network_access_authorization_rule_15, ise_active_directory_add_groups.active_directory_groups]
}

resource "ise_network_access_authorization_rule" "network_access_authorization_rule_17" {
  for_each = { for rule in local.network_access_authorization_rules : rule.key => rule if rule.rank == 17 }

  policy_set_id             = each.value.policy_set_id
  name                      = each.value.name
  rank                      = each.value.rank
  default                   = each.value.default
  state                     = each.value.state
  condition_type            = each.value.condition_type
  condition_id              = each.value.condition_id
  condition_is_negate       = each.value.condition_is_negate
  condition_attribute_name  = each.value.condition_attribute_name
  condition_attribute_value = each.value.condition_attribute_value
  condition_dictionary_name = each.value.condition_dictionary_name
  condition_operator        = each.value.condition_operator
  profiles                  = each.value.profiles
  security_group            = each.value.security_group
  children                  = each.value.children

  depends_on = [ise_network_access_authorization_rule.network_access_authorization_rule_16, ise_active_directory_add_groups.active_directory_groups]
}

resource "ise_network_access_authorization_rule" "network_access_authorization_rule_18" {
  for_each = { for rule in local.network_access_authorization_rules : rule.key => rule if rule.rank == 18 }

  policy_set_id             = each.value.policy_set_id
  name                      = each.value.name
  rank                      = each.value.rank
  default                   = each.value.default
  state                     = each.value.state
  condition_type            = each.value.condition_type
  condition_id              = each.value.condition_id
  condition_is_negate       = each.value.condition_is_negate
  condition_attribute_name  = each.value.condition_attribute_name
  condition_attribute_value = each.value.condition_attribute_value
  condition_dictionary_name = each.value.condition_dictionary_name
  condition_operator        = each.value.condition_operator
  profiles                  = each.value.profiles
  security_group            = each.value.security_group
  children                  = each.value.children

  depends_on = [ise_network_access_authorization_rule.network_access_authorization_rule_17, ise_active_directory_add_groups.active_directory_groups]
}

resource "ise_network_access_authorization_rule" "network_access_authorization_rule_19" {
  for_each = { for rule in local.network_access_authorization_rules : rule.key => rule if rule.rank == 19 }

  policy_set_id             = each.value.policy_set_id
  name                      = each.value.name
  rank                      = each.value.rank
  default                   = each.value.default
  state                     = each.value.state
  condition_type            = each.value.condition_type
  condition_id              = each.value.condition_id
  condition_is_negate       = each.value.condition_is_negate
  condition_attribute_name  = each.value.condition_attribute_name
  condition_attribute_value = each.value.condition_attribute_value
  condition_dictionary_name = each.value.condition_dictionary_name
  condition_operator        = each.value.condition_operator
  profiles                  = each.value.profiles
  security_group            = each.value.security_group
  children                  = each.value.children

  depends_on = [ise_network_access_authorization_rule.network_access_authorization_rule_18, ise_active_directory_add_groups.active_directory_groups]
}

locals {
  network_access_authorization_exception_rules = flatten([
    for ps in try(local.ise.network_access.policy_sets, []) : [
      for rule in try(ps.authorization_exception_rules, []) : {
        key                        = format("%s/%s", ps.name, rule.name)
        policy_set_id              = local.network_access_policy_set_ids[ps.name]
        name                       = rule.name
        rank                       = try(rule.rank, local.defaults.ise.network_access.policy_sets.authorization_exception_rules.rank, null)
        default                    = try(rule.default, local.defaults.ise.network_access.policy_sets.authorization_exception_rules.default, null)
        state                      = try(rule.state, local.defaults.ise.network_access.policy_sets.authorization_exception_rules.state, null)
        condition_type             = try(rule.condition.type, local.defaults.ise.network_access.policy_sets.authorization_exception_rules.condition.type, null)
        condition_id               = contains(local.known_conditions_network_access, try(rule.condition.name, "")) ? ise_network_access_condition.network_access_condition[rule.condition.name].id : try(data.ise_network_access_condition.network_access_condition[rule.condition.name].id, null)
        condition_is_negate        = try(rule.condition.is_negate, local.defaults.ise.network_access.policy_sets.authorization_exception_rules.condition.is_negate, null)
        condition_attribute_name   = try(rule.condition.attribute_name, local.defaults.ise.network_access.policy_sets.authorization_exception_rules.condition.attribute_name, null)
        condition_attribute_value  = try(rule.condition.attribute_value, local.defaults.ise.network_access.policy_sets.authorization_exception_rules.condition.attribute_value, null)
        condition_dictionary_name  = try(rule.condition.dictionary_name, local.defaults.ise.network_access.policy_sets.authorization_exception_rules.condition.dictionary_name, null)
        condition_dictionary_value = try(rule.condition.dictionary_value, local.defaults.ise.network_access.policy_sets.authorization_exception_rules.condition.dictionary_value, null)
        condition_operator         = try(rule.condition.operator, local.defaults.ise.network_access.policy_sets.authorization_exception_rules.condition.operator, null)
        profiles                   = try(rule.profiles, local.defaults.ise.network_access.policy_sets.authorization_exception_rules.profiles, null)
        security_group             = try(rule.security_group, local.defaults.ise.network_access.policy_sets.authorization_exception_rules.security_group, null)
        children = try([for i in rule.condition.children : {
          attribute_name   = try(i.attribute_name, local.defaults.ise.network_access.policy_sets.authorization_exception_rules.condition.attribute_name, null)
          attribute_value  = try(i.attribute_value, local.defaults.ise.network_access.policy_sets.authorization_exception_rules.condition.attribute_value, null)
          dictionary_name  = try(i.dictionary_name, local.defaults.ise.network_access.policy_sets.authorization_exception_rules.condition.dictionary_name, null)
          dictionary_value = try(i.dictionary_value, local.defaults.ise.network_access.policy_sets.authorization_exception_rules.condition.dictionary_value, null)
          condition_type   = try(i.type, local.defaults.ise.network_access.policy_sets.authorization_exception_rules.condition.type, null)
          is_negate        = try(i.is_negate, local.defaults.ise.network_access.policy_sets.authorization_exception_rules.condition.is_negate, null)
          operator         = try(i.operator, local.defaults.ise.network_access.policy_sets.authorization_exception_rules.condition.operator, null)
          id               = contains(local.known_conditions_network_access, try(i.name, "")) ? ise_network_access_condition.network_access_condition[i.name].id : try(data.ise_network_access_condition.network_access_condition[i.name].id, null)
          children = try([for j in i.children : {
            attribute_name   = try(j.attribute_name, local.defaults.ise.network_access.policy_sets.authorization_exception_rules.condition.attribute_name, null)
            attribute_value  = try(j.attribute_value, local.defaults.ise.network_access.policy_sets.authorization_exception_rules.condition.attribute_value, null)
            dictionary_name  = try(j.dictionary_name, local.defaults.ise.network_access.policy_sets.authorization_exception_rules.condition.dictionary_name, null)
            dictionary_value = try(j.dictionary_value, local.defaults.ise.network_access.policy_sets.authorization_exception_rules.condition.dictionary_value, null)
            condition_type   = try(j.type, local.defaults.ise.network_access.policy_sets.authorization_exception_rules.condition.type, null)
            is_negate        = try(j.is_negate, local.defaults.ise.network_access.policy_sets.authorization_exception_rules.condition.is_negate, null)
            operator         = try(j.operator, local.defaults.ise.network_access.policy_sets.authorization_exception_rules.condition.operator, null)
            id               = contains(local.known_conditions_network_access, try(j.name, "")) ? ise_network_access_condition.network_access_condition[j.name].id : try(data.ise_network_access_condition.network_access_condition[j.name].id, null)
          }], null)
        }], null)
      }
    ]
  ])
}

resource "ise_network_access_authorization_exception_rule" "network_access_authorization_exception_rule_0" {
  for_each = { for rule in local.network_access_authorization_exception_rules : rule.key => rule && (rule.rank == 0 || rule.rank == null) }

  policy_set_id             = each.value.policy_set_id
  name                      = each.value.name
  rank                      = each.value.rank
  default                   = each.value.default
  state                     = each.value.state
  condition_type            = each.value.condition_type
  condition_id              = each.value.condition_id
  condition_is_negate       = each.value.condition_is_negate
  condition_attribute_name  = each.value.condition_attribute_name
  condition_attribute_value = each.value.condition_attribute_value
  condition_dictionary_name = each.value.condition_dictionary_name
  condition_operator        = each.value.condition_operator
  profiles                  = each.value.profiles
  security_group            = each.value.security_group
  children                  = each.value.children

  depends_on = [ise_authorization_profile.authorization_profile, ise_trustsec_security_group.trustsec_security_group, time_sleep.sgt_wait, ise_endpoint_identity_group.endpoint_identity_group, ise_user_identity_group.user_identity_group, ise_active_directory_add_groups.active_directory_groups]
}

resource "ise_network_access_authorization_exception_rule" "network_access_authorization_exception_rule_1" {
  for_each = { for rule in local.network_access_authorization_exception_rules : rule.key => rule if rule.rank == 1 }

  policy_set_id             = each.value.policy_set_id
  name                      = each.value.name
  rank                      = each.value.rank
  default                   = each.value.default
  state                     = each.value.state
  condition_type            = each.value.condition_type
  condition_id              = each.value.condition_id
  condition_is_negate       = each.value.condition_is_negate
  condition_attribute_name  = each.value.condition_attribute_name
  condition_attribute_value = each.value.condition_attribute_value
  condition_dictionary_name = each.value.condition_dictionary_name
  condition_operator        = each.value.condition_operator
  profiles                  = each.value.profiles
  security_group            = each.value.security_group
  children                  = each.value.children

  depends_on = [ise_network_access_authorization_exception_rule.network_access_authorization_exception_rule_0, ise_active_directory_add_groups.active_directory_groups]
}

resource "ise_network_access_authorization_exception_rule" "network_access_authorization_exception_rule_2" {
  for_each = { for rule in local.network_access_authorization_exception_rules : rule.key => rule if rule.rank == 2 }

  policy_set_id             = each.value.policy_set_id
  name                      = each.value.name
  rank                      = each.value.rank
  default                   = each.value.default
  state                     = each.value.state
  condition_type            = each.value.condition_type
  condition_id              = each.value.condition_id
  condition_is_negate       = each.value.condition_is_negate
  condition_attribute_name  = each.value.condition_attribute_name
  condition_attribute_value = each.value.condition_attribute_value
  condition_dictionary_name = each.value.condition_dictionary_name
  condition_operator        = each.value.condition_operator
  profiles                  = each.value.profiles
  security_group            = each.value.security_group
  children                  = each.value.children

  depends_on = [ise_network_access_authorization_exception_rule.network_access_authorization_exception_rule_1, ise_active_directory_add_groups.active_directory_groups]
}

resource "ise_network_access_authorization_exception_rule" "network_access_authorization_exception_rule_3" {
  for_each = { for rule in local.network_access_authorization_exception_rules : rule.key => rule if rule.rank == 3 }

  policy_set_id             = each.value.policy_set_id
  name                      = each.value.name
  rank                      = each.value.rank
  default                   = each.value.default
  state                     = each.value.state
  condition_type            = each.value.condition_type
  condition_id              = each.value.condition_id
  condition_is_negate       = each.value.condition_is_negate
  condition_attribute_name  = each.value.condition_attribute_name
  condition_attribute_value = each.value.condition_attribute_value
  condition_dictionary_name = each.value.condition_dictionary_name
  condition_operator        = each.value.condition_operator
  profiles                  = each.value.profiles
  security_group            = each.value.security_group
  children                  = each.value.children

  depends_on = [ise_network_access_authorization_exception_rule.network_access_authorization_exception_rule_2, ise_active_directory_add_groups.active_directory_groups]
}

resource "ise_network_access_authorization_exception_rule" "network_access_authorization_exception_rule_4" {
  for_each = { for rule in local.network_access_authorization_exception_rules : rule.key => rule if rule.rank == 4 }

  policy_set_id             = each.value.policy_set_id
  name                      = each.value.name
  rank                      = each.value.rank
  default                   = each.value.default
  state                     = each.value.state
  condition_type            = each.value.condition_type
  condition_id              = each.value.condition_id
  condition_is_negate       = each.value.condition_is_negate
  condition_attribute_name  = each.value.condition_attribute_name
  condition_attribute_value = each.value.condition_attribute_value
  condition_dictionary_name = each.value.condition_dictionary_name
  condition_operator        = each.value.condition_operator
  profiles                  = each.value.profiles
  security_group            = each.value.security_group
  children                  = each.value.children

  depends_on = [ise_network_access_authorization_exception_rule.network_access_authorization_exception_rule_3, ise_active_directory_add_groups.active_directory_groups]
}

resource "ise_network_access_authorization_exception_rule" "network_access_authorization_exception_rule_5" {
  for_each = { for rule in local.network_access_authorization_exception_rules : rule.key => rule if rule.rank == 5 }

  policy_set_id             = each.value.policy_set_id
  name                      = each.value.name
  rank                      = each.value.rank
  default                   = each.value.default
  state                     = each.value.state
  condition_type            = each.value.condition_type
  condition_id              = each.value.condition_id
  condition_is_negate       = each.value.condition_is_negate
  condition_attribute_name  = each.value.condition_attribute_name
  condition_attribute_value = each.value.condition_attribute_value
  condition_dictionary_name = each.value.condition_dictionary_name
  condition_operator        = each.value.condition_operator
  profiles                  = each.value.profiles
  security_group            = each.value.security_group
  children                  = each.value.children

  depends_on = [ise_network_access_authorization_exception_rule.network_access_authorization_exception_rule_4, ise_active_directory_add_groups.active_directory_groups]
}

resource "ise_network_access_authorization_exception_rule" "network_access_authorization_exception_rule_6" {
  for_each = { for rule in local.network_access_authorization_exception_rules : rule.key => rule if rule.rank == 6 }

  policy_set_id             = each.value.policy_set_id
  name                      = each.value.name
  rank                      = each.value.rank
  default                   = each.value.default
  state                     = each.value.state
  condition_type            = each.value.condition_type
  condition_id              = each.value.condition_id
  condition_is_negate       = each.value.condition_is_negate
  condition_attribute_name  = each.value.condition_attribute_name
  condition_attribute_value = each.value.condition_attribute_value
  condition_dictionary_name = each.value.condition_dictionary_name
  condition_operator        = each.value.condition_operator
  profiles                  = each.value.profiles
  security_group            = each.value.security_group
  children                  = each.value.children

  depends_on = [ise_network_access_authorization_exception_rule.network_access_authorization_exception_rule_5, ise_active_directory_add_groups.active_directory_groups]
}

resource "ise_network_access_authorization_exception_rule" "network_access_authorization_exception_rule_7" {
  for_each = { for rule in local.network_access_authorization_exception_rules : rule.key => rule if rule.rank == 7 }

  policy_set_id             = each.value.policy_set_id
  name                      = each.value.name
  rank                      = each.value.rank
  default                   = each.value.default
  state                     = each.value.state
  condition_type            = each.value.condition_type
  condition_id              = each.value.condition_id
  condition_is_negate       = each.value.condition_is_negate
  condition_attribute_name  = each.value.condition_attribute_name
  condition_attribute_value = each.value.condition_attribute_value
  condition_dictionary_name = each.value.condition_dictionary_name
  condition_operator        = each.value.condition_operator
  profiles                  = each.value.profiles
  security_group            = each.value.security_group
  children                  = each.value.children

  depends_on = [ise_network_access_authorization_exception_rule.network_access_authorization_exception_rule_6, ise_active_directory_add_groups.active_directory_groups]
}

resource "ise_network_access_authorization_exception_rule" "network_access_authorization_exception_rule_8" {
  for_each = { for rule in local.network_access_authorization_exception_rules : rule.key => rule if rule.rank == 8 }

  policy_set_id             = each.value.policy_set_id
  name                      = each.value.name
  rank                      = each.value.rank
  default                   = each.value.default
  state                     = each.value.state
  condition_type            = each.value.condition_type
  condition_id              = each.value.condition_id
  condition_is_negate       = each.value.condition_is_negate
  condition_attribute_name  = each.value.condition_attribute_name
  condition_attribute_value = each.value.condition_attribute_value
  condition_dictionary_name = each.value.condition_dictionary_name
  condition_operator        = each.value.condition_operator
  profiles                  = each.value.profiles
  security_group            = each.value.security_group
  children                  = each.value.children

  depends_on = [ise_network_access_authorization_exception_rule.network_access_authorization_exception_rule_7, ise_active_directory_add_groups.active_directory_groups]
}

resource "ise_network_access_authorization_exception_rule" "network_access_authorization_exception_rule_9" {
  for_each = { for rule in local.network_access_authorization_exception_rules : rule.key => rule if rule.rank == 9 }

  policy_set_id             = each.value.policy_set_id
  name                      = each.value.name
  rank                      = each.value.rank
  default                   = each.value.default
  state                     = each.value.state
  condition_type            = each.value.condition_type
  condition_id              = each.value.condition_id
  condition_is_negate       = each.value.condition_is_negate
  condition_attribute_name  = each.value.condition_attribute_name
  condition_attribute_value = each.value.condition_attribute_value
  condition_dictionary_name = each.value.condition_dictionary_name
  condition_operator        = each.value.condition_operator
  profiles                  = each.value.profiles
  security_group            = each.value.security_group
  children                  = each.value.children

  depends_on = [ise_network_access_authorization_exception_rule.network_access_authorization_exception_rule_8, ise_active_directory_add_groups.active_directory_groups]
}

resource "ise_network_access_authorization_exception_rule" "network_access_authorization_exception_rule_10" {
  for_each = { for rule in local.network_access_authorization_exception_rules : rule.key => rule if rule.rank == 10 }

  policy_set_id             = each.value.policy_set_id
  name                      = each.value.name
  rank                      = each.value.rank
  default                   = each.value.default
  state                     = each.value.state
  condition_type            = each.value.condition_type
  condition_id              = each.value.condition_id
  condition_is_negate       = each.value.condition_is_negate
  condition_attribute_name  = each.value.condition_attribute_name
  condition_attribute_value = each.value.condition_attribute_value
  condition_dictionary_name = each.value.condition_dictionary_name
  condition_operator        = each.value.condition_operator
  profiles                  = each.value.profiles
  security_group            = each.value.security_group
  children                  = each.value.children

  depends_on = [ise_network_access_authorization_exception_rule.network_access_authorization_exception_rule_9, ise_active_directory_add_groups.active_directory_groups]
}

resource "ise_network_access_authorization_exception_rule" "network_access_authorization_exception_rule_11" {
  for_each = { for rule in local.network_access_authorization_exception_rules : rule.key => rule if rule.rank == 11 }

  policy_set_id             = each.value.policy_set_id
  name                      = each.value.name
  rank                      = each.value.rank
  default                   = each.value.default
  state                     = each.value.state
  condition_type            = each.value.condition_type
  condition_id              = each.value.condition_id
  condition_is_negate       = each.value.condition_is_negate
  condition_attribute_name  = each.value.condition_attribute_name
  condition_attribute_value = each.value.condition_attribute_value
  condition_dictionary_name = each.value.condition_dictionary_name
  condition_operator        = each.value.condition_operator
  profiles                  = each.value.profiles
  security_group            = each.value.security_group
  children                  = each.value.children

  depends_on = [ise_network_access_authorization_exception_rule.network_access_authorization_exception_rule_10, ise_active_directory_add_groups.active_directory_groups]
}

resource "ise_network_access_authorization_exception_rule" "network_access_authorization_exception_rule_12" {
  for_each = { for rule in local.network_access_authorization_exception_rules : rule.key => rule if rule.rank == 12 }

  policy_set_id             = each.value.policy_set_id
  name                      = each.value.name
  rank                      = each.value.rank
  default                   = each.value.default
  state                     = each.value.state
  condition_type            = each.value.condition_type
  condition_id              = each.value.condition_id
  condition_is_negate       = each.value.condition_is_negate
  condition_attribute_name  = each.value.condition_attribute_name
  condition_attribute_value = each.value.condition_attribute_value
  condition_dictionary_name = each.value.condition_dictionary_name
  condition_operator        = each.value.condition_operator
  profiles                  = each.value.profiles
  security_group            = each.value.security_group
  children                  = each.value.children

  depends_on = [ise_network_access_authorization_exception_rule.network_access_authorization_exception_rule_11, ise_active_directory_add_groups.active_directory_groups]
}

resource "ise_network_access_authorization_exception_rule" "network_access_authorization_exception_rule_13" {
  for_each = { for rule in local.network_access_authorization_exception_rules : rule.key => rule if rule.rank == 13 }

  policy_set_id             = each.value.policy_set_id
  name                      = each.value.name
  rank                      = each.value.rank
  default                   = each.value.default
  state                     = each.value.state
  condition_type            = each.value.condition_type
  condition_id              = each.value.condition_id
  condition_is_negate       = each.value.condition_is_negate
  condition_attribute_name  = each.value.condition_attribute_name
  condition_attribute_value = each.value.condition_attribute_value
  condition_dictionary_name = each.value.condition_dictionary_name
  condition_operator        = each.value.condition_operator
  profiles                  = each.value.profiles
  security_group            = each.value.security_group
  children                  = each.value.children

  depends_on = [ise_network_access_authorization_exception_rule.network_access_authorization_exception_rule_12, ise_active_directory_add_groups.active_directory_groups]
}

resource "ise_network_access_authorization_exception_rule" "network_access_authorization_exception_rule_14" {
  for_each = { for rule in local.network_access_authorization_exception_rules : rule.key => rule if rule.rank == 14 }

  policy_set_id             = each.value.policy_set_id
  name                      = each.value.name
  rank                      = each.value.rank
  default                   = each.value.default
  state                     = each.value.state
  condition_type            = each.value.condition_type
  condition_id              = each.value.condition_id
  condition_is_negate       = each.value.condition_is_negate
  condition_attribute_name  = each.value.condition_attribute_name
  condition_attribute_value = each.value.condition_attribute_value
  condition_dictionary_name = each.value.condition_dictionary_name
  condition_operator        = each.value.condition_operator
  profiles                  = each.value.profiles
  security_group            = each.value.security_group
  children                  = each.value.children

  depends_on = [ise_network_access_authorization_exception_rule.network_access_authorization_exception_rule_13, ise_active_directory_add_groups.active_directory_groups]
}

resource "ise_network_access_authorization_exception_rule" "network_access_authorization_exception_rule_15" {
  for_each = { for rule in local.network_access_authorization_exception_rules : rule.key => rule if rule.rank == 15 }

  policy_set_id             = each.value.policy_set_id
  name                      = each.value.name
  rank                      = each.value.rank
  default                   = each.value.default
  state                     = each.value.state
  condition_type            = each.value.condition_type
  condition_id              = each.value.condition_id
  condition_is_negate       = each.value.condition_is_negate
  condition_attribute_name  = each.value.condition_attribute_name
  condition_attribute_value = each.value.condition_attribute_value
  condition_dictionary_name = each.value.condition_dictionary_name
  condition_operator        = each.value.condition_operator
  profiles                  = each.value.profiles
  security_group            = each.value.security_group
  children                  = each.value.children

  depends_on = [ise_network_access_authorization_exception_rule.network_access_authorization_exception_rule_14, ise_active_directory_add_groups.active_directory_groups]
}

resource "ise_network_access_authorization_exception_rule" "network_access_authorization_exception_rule_16" {
  for_each = { for rule in local.network_access_authorization_exception_rules : rule.key => rule if rule.rank == 16 }

  policy_set_id             = each.value.policy_set_id
  name                      = each.value.name
  rank                      = each.value.rank
  default                   = each.value.default
  state                     = each.value.state
  condition_type            = each.value.condition_type
  condition_id              = each.value.condition_id
  condition_is_negate       = each.value.condition_is_negate
  condition_attribute_name  = each.value.condition_attribute_name
  condition_attribute_value = each.value.condition_attribute_value
  condition_dictionary_name = each.value.condition_dictionary_name
  condition_operator        = each.value.condition_operator
  profiles                  = each.value.profiles
  security_group            = each.value.security_group
  children                  = each.value.children

  depends_on = [ise_network_access_authorization_exception_rule.network_access_authorization_exception_rule_15, ise_active_directory_add_groups.active_directory_groups]
}

resource "ise_network_access_authorization_exception_rule" "network_access_authorization_exception_rule_17" {
  for_each = { for rule in local.network_access_authorization_exception_rules : rule.key => rule if rule.rank == 17 }

  policy_set_id             = each.value.policy_set_id
  name                      = each.value.name
  rank                      = each.value.rank
  default                   = each.value.default
  state                     = each.value.state
  condition_type            = each.value.condition_type
  condition_id              = each.value.condition_id
  condition_is_negate       = each.value.condition_is_negate
  condition_attribute_name  = each.value.condition_attribute_name
  condition_attribute_value = each.value.condition_attribute_value
  condition_dictionary_name = each.value.condition_dictionary_name
  condition_operator        = each.value.condition_operator
  profiles                  = each.value.profiles
  security_group            = each.value.security_group
  children                  = each.value.children

  depends_on = [ise_network_access_authorization_exception_rule.network_access_authorization_exception_rule_16, ise_active_directory_add_groups.active_directory_groups]
}

resource "ise_network_access_authorization_exception_rule" "network_access_authorization_exception_rule_18" {
  for_each = { for rule in local.network_access_authorization_exception_rules : rule.key => rule if rule.rank == 18 }

  policy_set_id             = each.value.policy_set_id
  name                      = each.value.name
  rank                      = each.value.rank
  default                   = each.value.default
  state                     = each.value.state
  condition_type            = each.value.condition_type
  condition_id              = each.value.condition_id
  condition_is_negate       = each.value.condition_is_negate
  condition_attribute_name  = each.value.condition_attribute_name
  condition_attribute_value = each.value.condition_attribute_value
  condition_dictionary_name = each.value.condition_dictionary_name
  condition_operator        = each.value.condition_operator
  profiles                  = each.value.profiles
  security_group            = each.value.security_group
  children                  = each.value.children

  depends_on = [ise_network_access_authorization_exception_rule.network_access_authorization_exception_rule_17, ise_active_directory_add_groups.active_directory_groups]
}

resource "ise_network_access_authorization_exception_rule" "network_access_authorization_exception_rule_19" {
  for_each = { for rule in local.network_access_authorization_exception_rules : rule.key => rule if rule.rank == 19 }

  policy_set_id             = each.value.policy_set_id
  name                      = each.value.name
  rank                      = each.value.rank
  default                   = each.value.default
  state                     = each.value.state
  condition_type            = each.value.condition_type
  condition_id              = each.value.condition_id
  condition_is_negate       = each.value.condition_is_negate
  condition_attribute_name  = each.value.condition_attribute_name
  condition_attribute_value = each.value.condition_attribute_value
  condition_dictionary_name = each.value.condition_dictionary_name
  condition_operator        = each.value.condition_operator
  profiles                  = each.value.profiles
  security_group            = each.value.security_group
  children                  = each.value.children

  depends_on = [ise_network_access_authorization_exception_rule.network_access_authorization_exception_rule_18, ise_active_directory_add_groups.active_directory_groups]
}

locals {
  network_access_authorization_global_exception_rules = [
    for rule in try(local.ise.network_access.authorization_global_exception_rules, []) : {
      name                       = rule.name
      rank                       = try(rule.rank, local.defaults.ise.network_access.authorization_global_exception_rules.rank, null)
      default                    = try(rule.default, local.defaults.ise.network_access.authorization_global_exception_rules.default, null)
      state                      = try(rule.state, local.defaults.ise.network_access.authorization_global_exception_rules.state, null)
      condition_type             = try(rule.condition.type, local.defaults.ise.network_access.authorization_global_exception_rules.condition.type, null)
      condition_id               = contains(local.known_conditions_network_access, try(rule.condition.name, "")) ? ise_network_access_condition.network_access_condition[rule.condition.name].id : try(data.ise_network_access_condition.network_access_condition[rule.condition.name].id, null)
      condition_is_negate        = try(rule.condition.is_negate, local.defaults.ise.network_access.authorization_global_exception_rules.condition.is_negate, null)
      condition_attribute_name   = try(rule.condition.attribute_name, local.defaults.ise.network_access.authorization_global_exception_rules.condition.attribute_name, null)
      condition_attribute_value  = try(rule.condition.attribute_value, local.defaults.ise.network_access.authorization_global_exception_rules.condition.attribute_value, null)
      condition_dictionary_name  = try(rule.condition.dictionary_name, local.defaults.ise.network_access.authorization_global_exception_rules.condition.dictionary_name, null)
      condition_dictionary_value = try(rule.condition.dictionary_value, local.defaults.ise.network_access.authorization_global_exception_rules.condition.dictionary_value, null)
      condition_operator         = try(rule.condition.operator, local.defaults.ise.network_access.authorization_global_exception_rules.condition.operator, null)
      profiles                   = try(rule.profiles, local.defaults.ise.network_access.authorization_global_exception_rules.profiles, null)
      security_group             = try(rule.security_group, local.defaults.ise.network_access.authorization_global_exception_rules.security_group, null)
      children = try([for i in rule.condition.children : {
        attribute_name   = try(i.attribute_name, local.defaults.ise.network_access.authorization_global_exception_rules.condition.attribute_name, null)
        attribute_value  = try(i.attribute_value, local.defaults.ise.network_access.authorization_global_exception_rules.condition.attribute_value, null)
        dictionary_name  = try(i.dictionary_name, local.defaults.ise.network_access.authorization_global_exception_rules.condition.dictionary_name, null)
        dictionary_value = try(i.dictionary_value, local.defaults.ise.network_access.authorization_global_exception_rules.condition.dictionary_value, null)
        condition_type   = try(i.type, local.defaults.ise.network_access.authorization_global_exception_rules.condition.type, null)
        is_negate        = try(i.is_negate, local.defaults.ise.network_access.authorization_global_exception_rules.condition.is_negate, null)
        operator         = try(i.operator, local.defaults.ise.network_access.authorization_global_exception_rules.condition.operator, null)
        id               = contains(local.known_conditions_network_access, try(i.name, "")) ? ise_network_access_condition.network_access_condition[i.name].id : try(data.ise_network_access_condition.network_access_condition[i.name].id, null)
        children = try([for j in i.children : {
          attribute_name   = try(j.attribute_name, local.defaults.ise.network_access.authorization_global_exception_rules.condition.attribute_name, null)
          attribute_value  = try(j.attribute_value, local.defaults.ise.network_access.authorization_global_exception_rules.condition.attribute_value, null)
          dictionary_name  = try(j.dictionary_name, local.defaults.ise.network_access.authorization_global_exception_rules.condition.dictionary_name, null)
          dictionary_value = try(j.dictionary_value, local.defaults.ise.network_access.authorization_global_exception_rules.condition.dictionary_value, null)
          condition_type   = try(j.type, local.defaults.ise.network_access.authorization_global_exception_rules.condition.type, null)
          is_negate        = try(j.is_negate, local.defaults.ise.network_access.authorization_global_exception_rules.condition.is_negate, null)
          operator         = try(j.operator, local.defaults.ise.network_access.authorization_global_exception_rules.condition.operator, null)
          id               = contains(local.known_conditions_network_access, try(j.name, "")) ? ise_network_access_condition.network_access_condition[j.name].id : try(data.ise_network_access_condition.network_access_condition[j.name].id, null)
        }], null)
      }], null)
    }
  ]
}

resource "ise_network_access_authorization_global_exception_rule" "network_access_authorization_global_exception_rule_0" {
  for_each = { for rule in local.network_access_authorization_global_exception_rules : rule.name => rule && (rule.rank == 0 || rule.rank == null) }

  name                      = each.value.name
  rank                      = each.value.rank
  default                   = each.value.default
  state                     = each.value.state
  condition_type            = each.value.condition_type
  condition_id              = each.value.condition_id
  condition_is_negate       = each.value.condition_is_negate
  condition_attribute_name  = each.value.condition_attribute_name
  condition_attribute_value = each.value.condition_attribute_value
  condition_dictionary_name = each.value.condition_dictionary_name
  condition_operator        = each.value.condition_operator
  profiles                  = each.value.profiles
  security_group            = each.value.security_group
  children                  = each.value.children

  depends_on = [ise_authorization_profile.authorization_profile, ise_trustsec_security_group.trustsec_security_group, time_sleep.sgt_wait, ise_endpoint_identity_group.endpoint_identity_group, ise_user_identity_group.user_identity_group, ise_active_directory_add_groups.active_directory_groups]
}

resource "ise_network_access_authorization_global_exception_rule" "network_access_authorization_global_exception_rule_1" {
  for_each = { for rule in local.network_access_authorization_global_exception_rules : rule.name => rule if rule.rank == 1 }

  name                      = each.value.name
  rank                      = each.value.rank
  default                   = each.value.default
  state                     = each.value.state
  condition_type            = each.value.condition_type
  condition_id              = each.value.condition_id
  condition_is_negate       = each.value.condition_is_negate
  condition_attribute_name  = each.value.condition_attribute_name
  condition_attribute_value = each.value.condition_attribute_value
  condition_dictionary_name = each.value.condition_dictionary_name
  condition_operator        = each.value.condition_operator
  profiles                  = each.value.profiles
  security_group            = each.value.security_group
  children                  = each.value.children

  depends_on = [ise_network_access_authorization_global_exception_rule.network_access_authorization_global_exception_rule_0, ise_active_directory_add_groups.active_directory_groups]
}

resource "ise_network_access_authorization_global_exception_rule" "network_access_authorization_global_exception_rule_2" {
  for_each = { for rule in local.network_access_authorization_global_exception_rules : rule.name => rule if rule.rank == 2 }

  name                      = each.value.name
  rank                      = each.value.rank
  default                   = each.value.default
  state                     = each.value.state
  condition_type            = each.value.condition_type
  condition_id              = each.value.condition_id
  condition_is_negate       = each.value.condition_is_negate
  condition_attribute_name  = each.value.condition_attribute_name
  condition_attribute_value = each.value.condition_attribute_value
  condition_dictionary_name = each.value.condition_dictionary_name
  condition_operator        = each.value.condition_operator
  profiles                  = each.value.profiles
  security_group            = each.value.security_group
  children                  = each.value.children

  depends_on = [ise_network_access_authorization_global_exception_rule.network_access_authorization_global_exception_rule_1, ise_active_directory_add_groups.active_directory_groups]
}

resource "ise_network_access_authorization_global_exception_rule" "network_access_authorization_global_exception_rule_3" {
  for_each = { for rule in local.network_access_authorization_global_exception_rules : rule.name => rule if rule.rank == 3 }

  name                      = each.value.name
  rank                      = each.value.rank
  default                   = each.value.default
  state                     = each.value.state
  condition_type            = each.value.condition_type
  condition_id              = each.value.condition_id
  condition_is_negate       = each.value.condition_is_negate
  condition_attribute_name  = each.value.condition_attribute_name
  condition_attribute_value = each.value.condition_attribute_value
  condition_dictionary_name = each.value.condition_dictionary_name
  condition_operator        = each.value.condition_operator
  profiles                  = each.value.profiles
  security_group            = each.value.security_group
  children                  = each.value.children

  depends_on = [ise_network_access_authorization_global_exception_rule.network_access_authorization_global_exception_rule_2, ise_active_directory_add_groups.active_directory_groups]
}

resource "ise_network_access_authorization_global_exception_rule" "network_access_authorization_global_exception_rule_4" {
  for_each = { for rule in local.network_access_authorization_global_exception_rules : rule.name => rule if rule.rank == 4 }

  name                      = each.value.name
  rank                      = each.value.rank
  default                   = each.value.default
  state                     = each.value.state
  condition_type            = each.value.condition_type
  condition_id              = each.value.condition_id
  condition_is_negate       = each.value.condition_is_negate
  condition_attribute_name  = each.value.condition_attribute_name
  condition_attribute_value = each.value.condition_attribute_value
  condition_dictionary_name = each.value.condition_dictionary_name
  condition_operator        = each.value.condition_operator
  profiles                  = each.value.profiles
  security_group            = each.value.security_group
  children                  = each.value.children

  depends_on = [ise_network_access_authorization_global_exception_rule.network_access_authorization_global_exception_rule_3, ise_active_directory_add_groups.active_directory_groups]
}

resource "ise_network_access_authorization_global_exception_rule" "network_access_authorization_global_exception_rule_5" {
  for_each = { for rule in local.network_access_authorization_global_exception_rules : rule.name => rule if rule.rank == 5 }

  name                      = each.value.name
  rank                      = each.value.rank
  default                   = each.value.default
  state                     = each.value.state
  condition_type            = each.value.condition_type
  condition_id              = each.value.condition_id
  condition_is_negate       = each.value.condition_is_negate
  condition_attribute_name  = each.value.condition_attribute_name
  condition_attribute_value = each.value.condition_attribute_value
  condition_dictionary_name = each.value.condition_dictionary_name
  condition_operator        = each.value.condition_operator
  profiles                  = each.value.profiles
  security_group            = each.value.security_group
  children                  = each.value.children

  depends_on = [ise_network_access_authorization_global_exception_rule.network_access_authorization_global_exception_rule_4, ise_active_directory_add_groups.active_directory_groups]
}

resource "ise_network_access_authorization_global_exception_rule" "network_access_authorization_global_exception_rule_6" {
  for_each = { for rule in local.network_access_authorization_global_exception_rules : rule.name => rule if rule.rank == 6 }

  name                      = each.value.name
  rank                      = each.value.rank
  default                   = each.value.default
  state                     = each.value.state
  condition_type            = each.value.condition_type
  condition_id              = each.value.condition_id
  condition_is_negate       = each.value.condition_is_negate
  condition_attribute_name  = each.value.condition_attribute_name
  condition_attribute_value = each.value.condition_attribute_value
  condition_dictionary_name = each.value.condition_dictionary_name
  condition_operator        = each.value.condition_operator
  profiles                  = each.value.profiles
  security_group            = each.value.security_group
  children                  = each.value.children

  depends_on = [ise_network_access_authorization_global_exception_rule.network_access_authorization_global_exception_rule_5, ise_active_directory_add_groups.active_directory_groups]
}

resource "ise_network_access_authorization_global_exception_rule" "network_access_authorization_global_exception_rule_7" {
  for_each = { for rule in local.network_access_authorization_global_exception_rules : rule.name => rule if rule.rank == 7 }

  name                      = each.value.name
  rank                      = each.value.rank
  default                   = each.value.default
  state                     = each.value.state
  condition_type            = each.value.condition_type
  condition_id              = each.value.condition_id
  condition_is_negate       = each.value.condition_is_negate
  condition_attribute_name  = each.value.condition_attribute_name
  condition_attribute_value = each.value.condition_attribute_value
  condition_dictionary_name = each.value.condition_dictionary_name
  condition_operator        = each.value.condition_operator
  profiles                  = each.value.profiles
  security_group            = each.value.security_group
  children                  = each.value.children

  depends_on = [ise_network_access_authorization_global_exception_rule.network_access_authorization_global_exception_rule_6, ise_active_directory_add_groups.active_directory_groups]
}

resource "ise_network_access_authorization_global_exception_rule" "network_access_authorization_global_exception_rule_8" {
  for_each = { for rule in local.network_access_authorization_global_exception_rules : rule.name => rule if rule.rank == 8 }

  name                      = each.value.name
  rank                      = each.value.rank
  default                   = each.value.default
  state                     = each.value.state
  condition_type            = each.value.condition_type
  condition_id              = each.value.condition_id
  condition_is_negate       = each.value.condition_is_negate
  condition_attribute_name  = each.value.condition_attribute_name
  condition_attribute_value = each.value.condition_attribute_value
  condition_dictionary_name = each.value.condition_dictionary_name
  condition_operator        = each.value.condition_operator
  profiles                  = each.value.profiles
  security_group            = each.value.security_group
  children                  = each.value.children

  depends_on = [ise_network_access_authorization_global_exception_rule.network_access_authorization_global_exception_rule_7, ise_active_directory_add_groups.active_directory_groups]
}

resource "ise_network_access_authorization_global_exception_rule" "network_access_authorization_global_exception_rule_9" {
  for_each = { for rule in local.network_access_authorization_global_exception_rules : rule.name => rule if rule.rank == 9 }

  name                      = each.value.name
  rank                      = each.value.rank
  default                   = each.value.default
  state                     = each.value.state
  condition_type            = each.value.condition_type
  condition_id              = each.value.condition_id
  condition_is_negate       = each.value.condition_is_negate
  condition_attribute_name  = each.value.condition_attribute_name
  condition_attribute_value = each.value.condition_attribute_value
  condition_dictionary_name = each.value.condition_dictionary_name
  condition_operator        = each.value.condition_operator
  profiles                  = each.value.profiles
  security_group            = each.value.security_group
  children                  = each.value.children

  depends_on = [ise_network_access_authorization_global_exception_rule.network_access_authorization_global_exception_rule_8, ise_active_directory_add_groups.active_directory_groups]
}

resource "ise_network_access_authorization_global_exception_rule" "network_access_authorization_global_exception_rule_10" {
  for_each = { for rule in local.network_access_authorization_global_exception_rules : rule.name => rule if rule.rank == 10 }

  name                      = each.value.name
  rank                      = each.value.rank
  default                   = each.value.default
  state                     = each.value.state
  condition_type            = each.value.condition_type
  condition_id              = each.value.condition_id
  condition_is_negate       = each.value.condition_is_negate
  condition_attribute_name  = each.value.condition_attribute_name
  condition_attribute_value = each.value.condition_attribute_value
  condition_dictionary_name = each.value.condition_dictionary_name
  condition_operator        = each.value.condition_operator
  profiles                  = each.value.profiles
  security_group            = each.value.security_group
  children                  = each.value.children

  depends_on = [ise_network_access_authorization_global_exception_rule.network_access_authorization_global_exception_rule_9, ise_active_directory_add_groups.active_directory_groups]
}

resource "ise_network_access_authorization_global_exception_rule" "network_access_authorization_global_exception_rule_11" {
  for_each = { for rule in local.network_access_authorization_global_exception_rules : rule.name => rule if rule.rank == 11 }

  name                      = each.value.name
  rank                      = each.value.rank
  default                   = each.value.default
  state                     = each.value.state
  condition_type            = each.value.condition_type
  condition_id              = each.value.condition_id
  condition_is_negate       = each.value.condition_is_negate
  condition_attribute_name  = each.value.condition_attribute_name
  condition_attribute_value = each.value.condition_attribute_value
  condition_dictionary_name = each.value.condition_dictionary_name
  condition_operator        = each.value.condition_operator
  profiles                  = each.value.profiles
  security_group            = each.value.security_group
  children                  = each.value.children

  depends_on = [ise_network_access_authorization_global_exception_rule.network_access_authorization_global_exception_rule_10, ise_active_directory_add_groups.active_directory_groups]
}

resource "ise_network_access_authorization_global_exception_rule" "network_access_authorization_global_exception_rule_12" {
  for_each = { for rule in local.network_access_authorization_global_exception_rules : rule.name => rule if rule.rank == 12 }

  name                      = each.value.name
  rank                      = each.value.rank
  default                   = each.value.default
  state                     = each.value.state
  condition_type            = each.value.condition_type
  condition_id              = each.value.condition_id
  condition_is_negate       = each.value.condition_is_negate
  condition_attribute_name  = each.value.condition_attribute_name
  condition_attribute_value = each.value.condition_attribute_value
  condition_dictionary_name = each.value.condition_dictionary_name
  condition_operator        = each.value.condition_operator
  profiles                  = each.value.profiles
  security_group            = each.value.security_group
  children                  = each.value.children

  depends_on = [ise_network_access_authorization_global_exception_rule.network_access_authorization_global_exception_rule_11, ise_active_directory_add_groups.active_directory_groups]
}

resource "ise_network_access_authorization_global_exception_rule" "network_access_authorization_global_exception_rule_13" {
  for_each = { for rule in local.network_access_authorization_global_exception_rules : rule.name => rule if rule.rank == 13 }

  name                      = each.value.name
  rank                      = each.value.rank
  default                   = each.value.default
  state                     = each.value.state
  condition_type            = each.value.condition_type
  condition_id              = each.value.condition_id
  condition_is_negate       = each.value.condition_is_negate
  condition_attribute_name  = each.value.condition_attribute_name
  condition_attribute_value = each.value.condition_attribute_value
  condition_dictionary_name = each.value.condition_dictionary_name
  condition_operator        = each.value.condition_operator
  profiles                  = each.value.profiles
  security_group            = each.value.security_group
  children                  = each.value.children

  depends_on = [ise_network_access_authorization_global_exception_rule.network_access_authorization_global_exception_rule_12, ise_active_directory_add_groups.active_directory_groups]
}

resource "ise_network_access_authorization_global_exception_rule" "network_access_authorization_global_exception_rule_14" {
  for_each = { for rule in local.network_access_authorization_global_exception_rules : rule.name => rule if rule.rank == 14 }

  name                      = each.value.name
  rank                      = each.value.rank
  default                   = each.value.default
  state                     = each.value.state
  condition_type            = each.value.condition_type
  condition_id              = each.value.condition_id
  condition_is_negate       = each.value.condition_is_negate
  condition_attribute_name  = each.value.condition_attribute_name
  condition_attribute_value = each.value.condition_attribute_value
  condition_dictionary_name = each.value.condition_dictionary_name
  condition_operator        = each.value.condition_operator
  profiles                  = each.value.profiles
  security_group            = each.value.security_group
  children                  = each.value.children

  depends_on = [ise_network_access_authorization_global_exception_rule.network_access_authorization_global_exception_rule_13, ise_active_directory_add_groups.active_directory_groups]
}

resource "ise_network_access_authorization_global_exception_rule" "network_access_authorization_global_exception_rule_15" {
  for_each = { for rule in local.network_access_authorization_global_exception_rules : rule.name => rule if rule.rank == 15 }

  name                      = each.value.name
  rank                      = each.value.rank
  default                   = each.value.default
  state                     = each.value.state
  condition_type            = each.value.condition_type
  condition_id              = each.value.condition_id
  condition_is_negate       = each.value.condition_is_negate
  condition_attribute_name  = each.value.condition_attribute_name
  condition_attribute_value = each.value.condition_attribute_value
  condition_dictionary_name = each.value.condition_dictionary_name
  condition_operator        = each.value.condition_operator
  profiles                  = each.value.profiles
  security_group            = each.value.security_group
  children                  = each.value.children

  depends_on = [ise_network_access_authorization_global_exception_rule.network_access_authorization_global_exception_rule_14, ise_active_directory_add_groups.active_directory_groups]
}

resource "ise_network_access_authorization_global_exception_rule" "network_access_authorization_global_exception_rule_16" {
  for_each = { for rule in local.network_access_authorization_global_exception_rules : rule.name => rule if rule.rank == 16 }

  name                      = each.value.name
  rank                      = each.value.rank
  default                   = each.value.default
  state                     = each.value.state
  condition_type            = each.value.condition_type
  condition_id              = each.value.condition_id
  condition_is_negate       = each.value.condition_is_negate
  condition_attribute_name  = each.value.condition_attribute_name
  condition_attribute_value = each.value.condition_attribute_value
  condition_dictionary_name = each.value.condition_dictionary_name
  condition_operator        = each.value.condition_operator
  profiles                  = each.value.profiles
  security_group            = each.value.security_group
  children                  = each.value.children

  depends_on = [ise_network_access_authorization_global_exception_rule.network_access_authorization_global_exception_rule_15, ise_active_directory_add_groups.active_directory_groups]
}

resource "ise_network_access_authorization_global_exception_rule" "network_access_authorization_global_exception_rule_17" {
  for_each = { for rule in local.network_access_authorization_global_exception_rules : rule.name => rule if rule.rank == 17 }

  name                      = each.value.name
  rank                      = each.value.rank
  default                   = each.value.default
  state                     = each.value.state
  condition_type            = each.value.condition_type
  condition_id              = each.value.condition_id
  condition_is_negate       = each.value.condition_is_negate
  condition_attribute_name  = each.value.condition_attribute_name
  condition_attribute_value = each.value.condition_attribute_value
  condition_dictionary_name = each.value.condition_dictionary_name
  condition_operator        = each.value.condition_operator
  profiles                  = each.value.profiles
  security_group            = each.value.security_group
  children                  = each.value.children

  depends_on = [ise_network_access_authorization_global_exception_rule.network_access_authorization_global_exception_rule_16, ise_active_directory_add_groups.active_directory_groups]
}

resource "ise_network_access_authorization_global_exception_rule" "network_access_authorization_global_exception_rule_18" {
  for_each = { for rule in local.network_access_authorization_global_exception_rules : rule.name => rule if rule.rank == 18 }

  name                      = each.value.name
  rank                      = each.value.rank
  default                   = each.value.default
  state                     = each.value.state
  condition_type            = each.value.condition_type
  condition_id              = each.value.condition_id
  condition_is_negate       = each.value.condition_is_negate
  condition_attribute_name  = each.value.condition_attribute_name
  condition_attribute_value = each.value.condition_attribute_value
  condition_dictionary_name = each.value.condition_dictionary_name
  condition_operator        = each.value.condition_operator
  profiles                  = each.value.profiles
  security_group            = each.value.security_group
  children                  = each.value.children

  depends_on = [ise_network_access_authorization_global_exception_rule.network_access_authorization_global_exception_rule_17, ise_active_directory_add_groups.active_directory_groups]
}

resource "ise_network_access_authorization_global_exception_rule" "network_access_authorization_global_exception_rule_19" {
  for_each = { for rule in local.network_access_authorization_global_exception_rules : rule.name => rule if rule.rank == 19 }

  name                      = each.value.name
  rank                      = each.value.rank
  default                   = each.value.default
  state                     = each.value.state
  condition_type            = each.value.condition_type
  condition_id              = each.value.condition_id
  condition_is_negate       = each.value.condition_is_negate
  condition_attribute_name  = each.value.condition_attribute_name
  condition_attribute_value = each.value.condition_attribute_value
  condition_dictionary_name = each.value.condition_dictionary_name
  condition_operator        = each.value.condition_operator
  profiles                  = each.value.profiles
  security_group            = each.value.security_group
  children                  = each.value.children

  depends_on = [ise_network_access_authorization_global_exception_rule.network_access_authorization_global_exception_rule_18, ise_active_directory_add_groups.active_directory_groups]
}
