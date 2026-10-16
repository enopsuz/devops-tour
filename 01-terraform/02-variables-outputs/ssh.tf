resource "hcloud_ssh_key" "az_ssh_key" {
  name       = "${local.name_prefix}-key"
  public_key = var.ssh_public_key
  labels     = local.common_labels
}