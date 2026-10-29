locals {
  # Your full token string (can come from a variable, resource, or provider output)
  raw_token = proxmox_virtual_environment_user_token.dashy_token.value # or var.full_token_string

  # 1. Split on "=" to separate the ID from the UUID secret
  # ["dashy-monitor@pve!dashy-token", "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"]
  token_parts = split("=", local.raw_token)

  # 2. Extract UUID (the right side of "=")
  extracted_uuid = local.token_parts[1]

  # 3. Split the left side on "!" to get user_id and token_name
  # ["dashy-monitor@pve", "dashy-token"]
  id_parts = split("!", local.token_parts[0])

  extracted_user_id    = local.id_parts[0]
  extracted_token_name = local.id_parts[1]
}

# Write separated variables directly to your Ansible file
resource "local_file" "ansible_vault" {
  filename        = "${path.module}/../ansible/group_vars/all/vault.yml"
  file_permission = "0600"
  content         = <<-EOT
proxmox_dashy_token_user_id: "${local.extracted_user_id}"
proxmox_dashy_token_name: "${local.extracted_token_name}"
proxmox_dashy_token_uuid: "${local.extracted_uuid}"
EOT
}