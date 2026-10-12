terraform {
  required_providers {
    hcloud = {
      source  = "hetznercloud/hcloud"
      version = "~> 1.70"
    }
  }
}

provider "hcloud" {
  token = "secret-token"
}

resource "hcloud_network" "art_net" {
  name     = "art-net"
  ip_range = "10.10.0.0/16"
}

resource "hcloud_network_subnet" "art_subnet" {
  type         = "cloud"
  network_id   = hcloud_network.art_net.id
  network_zone = "eu-central"
  ip_range     = "10.10.0.0/24"
}

resource "hcloud_network_subnet" "art_subnet_2" {
  type         = "cloud"
  network_id   = hcloud_network.art_net.id
  network_zone = "eu-central"
  ip_range     = "10.10.1.0/24"
}

resource "hcloud_server" "node1" {
  name        = "node1"
  image       = "ubuntu-24.04"
  server_type = "cx33"
  location    = "fsn1"

  network {
    subnet_id = hcloud_network_subnet.art_subnet.id
    ip        = "10.10.0.2"
  }
  public_net {
    ipv4_enabled = false
    ipv6_enabled = true
  }
}