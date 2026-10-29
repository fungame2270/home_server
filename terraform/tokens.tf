resource "proxmox_virtual_environment_role" "dashy_monitor" {
  role_id = "DashyMonitor"
  privileges = [
    "VM.Audit",
    "Sys.Audit",
    "Datastore.Audit"
  ]
}

resource "proxmox_virtual_environment_user" "dashy_user" {
  user_id = "dashy-monitor@pve"
  comment = "Managed by Terraform for Dashy"
}

resource "proxmox_virtual_environment_user_token" "dashy_token" {
  user_id               = proxmox_virtual_environment_user.dashy_user.user_id
  token_name            = "dashy-token"
  privileges_separation  = false
  comment               = "API token for Dashy widgets"
}

resource "proxmox_virtual_environment_acl" "dashy_acl" {
  path      = "/"
  role_id   = proxmox_virtual_environment_role.dashy_monitor.role_id
  user_id   = proxmox_virtual_environment_user.dashy_user.user_id
  propagate = true
}

output "token_id" {
  description = "The token identifier for Dashy (tokenId)"
  value       = "${proxmox_virtual_environment_user.dashy_user.user_id}!${proxmox_virtual_environment_user_token.dashy_token.token_name}"
}

output "token_secret" {
  description = "The raw token secret UUID (tokenSecret)"
  value       = proxmox_virtual_environment_user_token.dashy_token.value
  sensitive   = true
}

output "full_token_string" {
  description = "Formatted token for PROXMOX_VE_API_TOKEN environment variable"
  value       = "${proxmox_virtual_environment_user.dashy_user.user_id}!${proxmox_virtual_environment_user_token.dashy_token.token_name}=${proxmox_virtual_environment_user_token.dashy_token.value}"
  sensitive   = true
}