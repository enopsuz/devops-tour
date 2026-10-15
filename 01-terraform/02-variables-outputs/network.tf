resource "hcloud_network" "lab_network" {
  name     = local.network.name
  ip_range = local.network.range
  labels   = local.common_labels
}

resource "hcloud_network_subnet" "lab_subnet" {
  network_id   = hcloud_network.lab_network.id
  type         = "cloud"
  network_zone = local.service.zone
  ip_range     = local.network.subnet_range
}