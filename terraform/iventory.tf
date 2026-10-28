resource "local_file" "ansible_inventory" {
  filename = "${path.module}/../ansible/inventory.ini"
  content  = <<-EOT
    [adguard]
    ${split("/", proxmox_virtual_environment_container.adguard.initialization[0].ip_config[0].ipv4[0].address)[0]}

    [dashy]
    ${split("/", proxmox_virtual_environment_container.dashy.initialization[0].ip_config[0].ipv4[0].address)[0]}

    [caddy]
    ${split("/", proxmox_virtual_environment_container.caddy.initialization[0].ip_config[0].ipv4[0].address)[0]}

    [all:vars]
    ansible_user=root
    ansible_ssh_private_key_file=~/.ssh/id_ed25519
    ansible_ssh_common_args='-o StrictHostKeyChecking=no'
  EOT
}