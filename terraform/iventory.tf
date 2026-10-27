resource "local_file" "ansible_inventory" {
  filename = "${path.module}/../ansible/inventory.ini"
  content  = <<-EOT
    [adguard]
    ${proxmox_lxc.adguard.network[0].ip}

    [music_assistant]
    ${proxmox_lxc.music_assistant.network[0].ip}

    [all:vars]
    ansible_user=root
    ansible_ssh_private_key_file=~/.ssh/id_ed25519
    ansible_ssh_common_args='-o StrictHostKeyChecking=no'
  EOT
}