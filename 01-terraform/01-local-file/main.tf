terraform {
    required_providers {
      local = {
        source = "hashicorp/local"
        version = "~> 2.9"
      }
    }
}

resource "local_file" "welcome_note" {
  filename = "${path.module}/welcome.txt"
  content = "DevOps Tour - 1-kun: Terraform bilan ilk qadam qo'yildi!\n"
}