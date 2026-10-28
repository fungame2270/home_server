resource "proxmox_virtual_environment_file" "alpine_ansible_template" {
  content_type = "vztmpl"
  datastore_id = "local"
  node_name    = "pve"

  source_file {
    path      = "https://github.com/fungame2270/home_server/releases/download/v1.0.0/alpine-3.24-ansible.tar.zst"
    file_name = "alpine-3.24-ansible.tar.zst"
  }
}