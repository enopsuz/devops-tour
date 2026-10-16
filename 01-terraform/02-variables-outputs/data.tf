data "hcloud_image" "ubuntu_26" {
  name              = "ubuntu-26.04"
  with_architecture = "x86"
}