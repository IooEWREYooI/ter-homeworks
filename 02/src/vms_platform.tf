### common vars
variable "vms_resources" {
  default = {
    web={
      cores=2
      memory=1
      core_fraction=5
    },
    db= {
      cores=2
      memory=2
      core_fraction=20
    }
  }
}

variable   "metadata"  {
  default = {
    serial-port-enable = 1
    ssh-keys           = "ubuntu:<SSH_PUB_KEY>"
  }
}

### vpc
variable "vpc_db_subnet_name" {
  type        = string
  default     = "develop-db"
}

variable "vpc_db_subnet_cidr" {
  type        = list(string)
  default     = ["10.1.1.0/24"]
}

### vm_web_ vars
variable "vm_web_family" {
  type = string
  default ="ubuntu-2004-lts"
}

variable "vm_web_name" {
  type = string
  default ="netology-develop-platform-web"
}

variable "vm_web_platform" {
  type = string
  default = "standard-v2"
}

# variable "vm_web_cores" {
#   type = number
#   default = 2
# }
#
# variable "vm_web_memory" {
#   type = number
#   default = 1
# }
#
# variable "vm_web_fraction" {
#   type = number
#   default = 5
# }

variable "vm_web_preemptible" {
  type = bool
  default = true
}

variable "vm_web_nat" {
  type = bool
  default = true
}

# variable "vm_web_serial_port" {
#   type = number
#   default = 1
# }

### vm_db_ vars
variable "vm_db_family" {
  type = string
  default ="ubuntu-2004-lts"
}

variable "vm_db_name" {
  type = string
  default ="netology-develop-platform-db"
}

variable "vm_db_platform" {
  type = string
  default = "standard-v2"
}

# variable "vm_db_cores" {
#   type = number
#   default = 2
# }
#
# variable "vm_db_memory" {
#   type = number
#   default = 2
# }
#
# variable "vm_db_fraction" {
#   type = number
#   default = 20
# }

variable "vm_db_preemptible" {
  type = bool
  default = true
}

variable "vm_db_nat" {
  type = bool
  default = true
}

# variable "vm_db_serial_port" {
#   type = number
#   default = 1
# }

variable "vm_db_zone" {
  type = string
  default = "ru-central1-b"
}