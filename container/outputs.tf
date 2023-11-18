# ------------------- Outputs configration -------------------
# To access these, type in the terminal:
#   *terraform output
#   *terraform show

# output "container-name" {
#   value = docker_container.nodered_container.name # Use the splat operator, "*" to show all containers
#   description = "The name of the container"
# }

# output "ip-address" {
#   # For each container, show the ip_address:ext_port
#   value = [for i in docker_container.nodered_container[*]: join(":", [i.ip_address], i.ports[*]["external"])] 
#   description = "The IP address and external port of the container"
# }


output "application_access" {
  value = { for x in docker_container.app_container[*] : x.name => join(":", [x.ip_address], x.ports[*]["external"]) }
}
