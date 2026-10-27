resource "proxmox_lxc" "music_assistant" {
  target_node  = "dev1"
  vmid         = 201
  hostname     = "music-assistant"
  ostemplate   = "local:vztmpl/ubuntu-24.04-standard_24.04-2_amd64.tar.zst"
  password     = var.lxc_password
  unprivileged = true

  cores  = 1
  memory = 1024

  rootfs {
    storage = "local-lvm"
    size    = "5G"
  }

  network {
    name   = "eth0"
    bridge = "vmbr0"
    ip     = "192.168.30.23/24"
    gw     = "192.168.30.1"
  }

  ssh_public_keys = file("~/.ssh/id_ed25519.pub")
  start           = true
}

output "music_assistant_ip" {
  value = proxmox_lxc.music_assistant.network[0].ip
}