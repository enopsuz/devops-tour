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

variable "db_server" {
  type = object({
    server_type = string
  })
  validation {
    condition     = contains(["cx23", "cx33", "cx43", "cx53"], var.db_server.server_type)
    error_message = "db_server.server_type must be one of: cx23, cx33, cx43, cx53"
  }
}

variable "app_server" {
  type = object({
    server_type = string
    count       = optional(number, 1)
  })
  validation {
    condition     = contains(["cx23", "cx33", "cx43", "cx53"], var.app_server.server_type)
    error_message = "app_server.server_type must be one of: cx23, cx33, cx43, cx53"
  }
  validation {
    condition     = var.app_server.count > 0
    error_message = "app_server.count must be greater than 0"
  }
}

variable "ssh_public_key" {
  type        = string
  description = "Serverga kirish uchun public kalit (ssh-ed25519 AAAA...)"
}