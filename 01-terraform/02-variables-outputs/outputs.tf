output "app_server_public_ip" {
  value = hcloud_server.app_server[*].ipv4_address
}

output "app_server_private_ip" {
  value = hcloud_server.app_server[*].network[*].ip
}

output "db_server_private_ip" {
  value = hcloud_server.db_server.network[*].ip
}

output "network_id" {
  value = hcloud_network.lab_network.id
}

output "ssh_command" {
  value = "ssh root@${hcloud_server.app_server[0].ipv4_address}"
}