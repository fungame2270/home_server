variable "pm_api_url" {
  type        = string
  description = "The Proxmox API URL (e.g., https://192.168.1.100:8006/api2/json)"
}

variable "pm_api_token_id" {
  type        = string
  description = "The Proxmox API token ID (e.g., terraform@pve!tf-token)"
}

variable "pm_api_token_secret" {
  type        = string
  description = "The Proxmox API token UUID secret"
  sensitive   = true
}

variable "lxc_password" {
  type        = string
  description = "Root password for LXC containers"
  sensitive   = true
}