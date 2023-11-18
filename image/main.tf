# Deploy docker image.  Docker images act as a set of instructions to build a Docker container, like a template.
# An image is a snapshot of the environment 

resource "docker_image" "container_image" {
  name = var.image_in
}