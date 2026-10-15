resource "hcloud_server" "app_server" {
  name        = local.app.name
  image       = "debian-12"
  server_type = var.app_server_type
  location    = local.service.location
  public_net {
    ipv4_enabled = true
    ipv6_enabled = true
  }
  labels = local.common_labels

  network {
    subnet_id = hcloud_network_subnet.lab_subnet.id
    ip        = "10.0.0.3"
  }
}

resource "hcloud_server" "db_server" {
  name        = local.db.name
  image       = "debian-12"
  server_type = var.db_server_type
  location    = local.service.location
  public_net {
    ipv4_enabled = false
    ipv6_enabled = false
  }
  labels = local.common_labels

  network {
    subnet_id = hcloud_network_subnet.lab_subnet.id
    ip        = "10.0.0.2"
  }
}