output "app_server_public_ip" {
  value = hcloud_server.app_server[*].ipv4_address
}

output "app_server_private_ip" {
  value = hcloud_server.app_server[*].network[*].ip
}

output "db_server_private_ip" {
  value = hcloud_server.db_server.network[*].ip
}