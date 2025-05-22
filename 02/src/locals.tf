# locals {
#   name-web = "netology-${var.vpc_name}-${var.vm_web_cores}-${var.vm_web_memory}-platform-web"
#   name-db = "netology-${var.vpc_name}-${var.vm_db_cores}-${var.vm_db_memory}-platform-db"
# }
locals {
  name-web = "netology-${var.vpc_name}-platform-web"
  name-db = "netology-${var.vpc_name}-platform-db"
}
