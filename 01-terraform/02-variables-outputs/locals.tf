locals {
  name_prefix = "${var.project}-${var.environment}"

  service = {
    zone     = "eu-central"
    location = "fsn1"
  }

  app = { name = "${local.name_prefix}-app" }
  db  = { name = "${local.name_prefix}-db" }

  network = {
    name         = "${local.name_prefix}-network"
    range        = "10.0.0.0/16"
    subnet_range = "10.0.0.0/24"
  }

  common_labels = {
    project     = local.project
    environment = var.environment
    managed_by  = "terraform"
  }

}
