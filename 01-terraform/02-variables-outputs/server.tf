resource "hcloud_server" "app_server" {
  count       = var.environment == "prod" ? 2 : 1
  name        = "${local.app.name}-${count.index}"
  image       = data.hcloud_image.ubuntu_26.id
  server_type = var.app_server_type
  location    = local.service.location
  public_net {
    ipv4_enabled = true
    ipv6_enabled = true
  }
  labels = merge(local.common_labels, { role = "app" })

  network {
    subnet_id = hcloud_network_subnet.lab_subnet.id
    ip        = "10.0.0.${count.index + 3}"
  }

  ssh_keys = [hcloud_ssh_key.az_ssh_key.id]
}

resource "hcloud_server" "db_server" {
  name        = local.db.name
  image       = data.hcloud_image.ubuntu_26.id
  server_type = var.db_server_type
  location    = local.service.location
  public_net {
    ipv4_enabled = false
    ipv6_enabled = false
  }
  labels = merge(local.common_labels, { role = "db" })

  network {
    subnet_id = hcloud_network_subnet.lab_subnet.id
    ip        = "10.0.0.2"
  }

  ssh_keys = [hcloud_ssh_key.az_ssh_key.id]
}