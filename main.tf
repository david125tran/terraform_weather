# ------------------- View your Deployment -------------------
# Access the EC2 compute instance that's running on cloud9 to access your deployment:
# (1st) obtain the ip address of the instance.  Type in the terminal:
#   curl http://169.254.169.254/latest/meta-data/public-ipv4
#   Terminal will return something like this: 34.205.147.125ubuntu:~/environment/terraform-docker
#   The IP address is: 34.205.147.125
# (2nd) obtain the external port:
#   Terraform show
#   Scroll to the ports and obtain the external port
# (3rd) In your browswer type:
#   The ip address:external port
#   Example: 34.205.147.125:1981

# ------------------- Module -------------------
module "image" {
  source   = "./image"
  for_each = local.deployment
  image_in = each.value.image
}

# ------------------- Deply docker container named "nodered_container"-------------------
module "container" {
  source            = "./container"
  count_in          = each.value.container_count
  for_each          = local.deployment
  name_in           = each.key
  image_in          = module.image[each.key].image_out
  int_port_in       = each.value.int
  ext_port_in       = each.value.ext
  volumes_in        = each.value.volumes 
}


