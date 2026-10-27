resource "proxmox_lxc" "caddy" {
  target_node  = "pve"
  vmid         = 302
  hostname     = "caddy"
  ostemplate   = var.lxc_image
  password     = var.lxc_password
  unprivileged = true

  onboot = true

  cores  = 1
  memory = 256
  swap   = 256

  rootfs {
    storage = "local-lvm"
    size    = "3G"
  }

  network {
    name   = "eth0"
    bridge = "vmbr0"
    ip     = "192.168.30.32/24"
    gw     = "192.168.30.1"
  }

  ssh_public_keys = file("~/.ssh/id_ed25519.pub")
  start           = true
}

output "caddy_ip" {
  value = proxmox_lxc.caddy.network[0].ip
}