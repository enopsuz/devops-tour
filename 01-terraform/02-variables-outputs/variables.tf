variable "hcloud_token" {
  type        = string
  description = "Hetzner Cloud API tokeni (lab project). Faqat TF_VAR_hcloud_token orqali beriladi"
  sensitive   = true
}

variable "project" {
  type        = string
  description = "Project name for the server"
}

variable "environment" {
  type        = string
  description = "Muhit nomi: dev yoki prod. Resurs nomlari va label'larida ishlatiladi"
  validation {
    condition     = contains(["dev", "prod"], var.environment)
    error_message = "environment must be one of: dev or prod"
  }
}

variable "db_server_type" {
  type        = string
  description = "DB server uchun Hetzner server turi (masalan cx23)"
  validation {
    condition     = contains(["cx23", "cx33", "cx43", "cx53"], var.db_server_type)
    error_message = "db_server_type must be one of: cx23, cx33, cx43, cx53"
  }
}

variable "app_server_type" {
  type        = string
  description = "App server uchun Hetzner server turi (masalan cx23)"
  validation {
    condition     = contains(["cx23", "cx33", "cx43", "cx53"], var.app_server_type)
    error_message = "app_server_type must be one of: cx23, cx33, cx43, cx53"
  }
}

variable "ssh_public_key" {
  type        = string
  description = "Serverga kirish uchun public kalit (ssh-ed25519 AAAA...)"
}