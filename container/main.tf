# ------------------- Deply docker container named "nodered_container"-------------------
# ------------------- Generate random string(s) for unique container names -------------------
resource "random_string" "random" {
  count   = var.count_in
  length  = 4
  special = false # no special characters
  upper   = false # no upper case characters
}

resource "docker_container" "app_container" {
  count = var.count_in
  # Give a different name to each container:
  name  = join("-", [var.name_in, terraform.workspace, random_string.random[count.index].result])
  image = var.image_in

  # Port configuration: Nodered needs int/ext ports to run: 
  ports {
    internal = var.int_port_in
    external = var.ext_port_in[count.index]
  }

  # Volume configuration
  dynamic "volumes" {
    for_each = var.volumes_in
    content {
      container_path = volumes.value["container_path_each"]
      volume_name    = module.volume[count.index].volume_output[volumes.key]
    }
  }
  provisioner "local-exec" {
    command = "echo ${self.name}: ${self.ip_address}:${join("", [for x in self.ports[*]["external"] : x])}>> containers.txt"
  }

  provisioner "local-exec" {
    when    = destroy
    command = "rm -f containers.txt"
  }
}

module "volume" {
  source = "./volume"
  count = var.count_in
  volume_count = length(var.volumes_in)
  volume_name = "${var.name_in}-${terraform.workspace}-${random_string.random[count.index].result}-volume"
  }

