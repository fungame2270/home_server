resource "proxmox_virtual_environment_container" "music_assistant" {
  node_name    = "pve"
  vm_id        = 204
  unprivileged = true

  start_on_boot = true
  started       = true

  features {
    nesting = true
  }

  cpu {
    cores = 2
  }

  memory {
    dedicated = 1536
  }

  disk {
    datastore_id = "local-lvm"
    size         = 8
  }

  operating_system {
    template_file_id = proxmox_virtual_environment_file.alpine_ansible_template.id
    type             = "alpine"
  }

  initialization {
    hostname = "music-assistant"

    user_account {
      password = var.lxc_password
      keys = [
        trimspace(file("~/.ssh/id_ed25519.pub"))
      ]
    }

    ip_config {
      ipv4 {
        address = "192.168.30.24/24"
        gateway = "192.168.30.1"
      }
    }
  }

  network_interface {
    name   = "eth0"
    bridge = "vmbr0"
  }
}

output "music_assistant_ip" {
  value = proxmox_virtual_environment_container.music_assistant.initialization[0].ip_config[0].ipv4[0].address
}