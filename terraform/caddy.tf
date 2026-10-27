resource "proxmox_virtual_environment_container" "caddy" {
  node_name    = "pve"
  vm_id        = 302
  unprivileged = true

  start_on_boot = true
  started       = true

  cpu {
    cores = 1
  }

  memory {
    dedicated = 256
    swap      = 256
  }

  disk {
    datastore_id = "local-lvm"
    size         = 3
  }

  operating_system {
    template_file_id = proxmox_virtual_environment_file.alpine_ansible_template.id
    type             = "alpine"
  }

  initialization {
    hostname = "caddy"

    user_account {
      password = var.lxc_password
      keys = [
        trimspace(file("~/.ssh/id_ed25519.pub"))
      ]
    }

    ip_config {
      ipv4 {
        address = "192.168.30.32/24"
        gateway = "192.168.30.1"
      }
    }
  }

  network_interface {
    name   = "eth0"
    bridge = "vmbr0"
  }
}

output "caddy_ip" {
  value = proxmox_virtual_environment_container.caddy.initialization[0].ip_config[0].ipv4[0].address
}