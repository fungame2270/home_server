variable "pve_endpoint" {
  type        = string
  description = "The Proxmox API URL (e.g., https://192.168.1.100:8006)"
}

variable "pve_token_id" {
  type        = string
  description = "The Proxmox API token ID (e.g., terraform@pve!tf-token)"
}

variable "pve_token_secret" {
  type        = string
  description = "The Proxmox API token UUID secret"
  sensitive   = true
}

variable "lxc_password" {
  type        = string
  description = "Root password for LXC containers"
  sensitive   = true
}

variable "lxc_image" {
  type        = string
  description = "The LXC image template to use (e.g., local:alpine-3.24-default_20260714_amd64.tar.xz)"
  default     = "local:vztmpl/alpine-3.24-default_20260714_amd64.tar.xz"
}