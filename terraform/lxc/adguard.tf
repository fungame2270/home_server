resource "proxmox_lxc" "adguard" {
  target_node  = "pve"
  vmid         = 301
  hostname     = "adguard"
  ostemplate   = var.lxc_image
  password     = var.lxc_password
  unprivileged = true

  cores  = 1
  memory = 512

  rootfs {
    storage = "local-lvm"
    size    = "2G"
  }

  network {
    name   = "eth0"
    bridge = "vmbr0"
    ip     = "192.168.30.31/24"
    gw     = "192.168.30.1"
  }

  ssh_public_keys = file("~/.ssh/id_ed25519.pub")
  start           = true
}

output "adguard_ip" {
  value = proxmox_lxc.adguard.network[0].ip
}