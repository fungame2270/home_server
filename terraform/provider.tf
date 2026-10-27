terraform {
  required_version = ">= 1.5.0"

  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "~> 0.68.0" # or latest 0.x release
    }
    local = {
      source  = "hashicorp/local"
      version = "~> 2.5"
    }
  }
}

provider "proxmox" {
  endpoint = var.pve_endpoint
  insecure = true

  api_token = "${var.pve_token_id}=${var.pve_token_secret}"

  ssh {
    agent    = true
    username = "root"
  }
}