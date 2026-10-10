terraform {
  required_version = ">= 1.16"
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 4.6"
    }
  }
}

provider "docker" {
  context = "desktop-linux"
}

resource "docker_network" "todo_net" {
  name = "tour-todo-network"
}

resource "docker_volume" "todo_db_data" {
  name = "tour-todo-db-data"
}

resource "docker_image" "postgres" {
  name         = "postgres:16-alpine"
  keep_locally = true
}

resource "docker_container" "todo_db" {
  name  = "tour-todo-db"
  image = docker_image.postgres.image_id

  env = [
    "POSTGRES_DB=todo",
    "POSTGRES_USER=todo",
    "POSTGRES_PASSWORD=todo"
  ]

  ports {
    internal = 5432
    external = 5432
  }

  volumes {
    volume_name    = docker_volume.todo_db_data.name
    container_path = "/var/lib/postgresql/data"
  }

  networks_advanced {
    name = docker_network.todo_net.name
  }
}