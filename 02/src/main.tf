resource "yandex_vpc_network" "develop" {
  name = var.vpc_name
}
resource "yandex_vpc_subnet" "develop" {
  name           = var.vpc_name
  zone           = var.default_zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.default_cidr
}

resource "yandex_vpc_subnet" "develop_db" {
  name           = var.vpc_db_subnet_name
  zone           = var.vm_db_zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.vpc_db_subnet_cidr
}

data "yandex_compute_image" "ubuntu" {
  family = var.vm_web_family
}
resource "yandex_compute_instance" "platform" {
  #name        = "netology-develop-platform-web"
  #name = var.vm_web_name
  name = local.name-web
  #platform_id = "standard-v2"
  platform_id = var.vm_web_platform

  resources {
    #cores         = 2
    #cores = var.vm_web_cores
    cores = var.vms_resources.web.cores
    #memory        = 1
    #memory = var.vm_web_memory
    memory = var.vms_resources.web.memory
    #core_fraction = 5
    #core_fraction = var.vm_web_fraction
    core_fraction = var.vms_resources.web.core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }
  scheduling_policy {
    #preemptible = true
    preemptible = var.vm_web_preemptible
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    #nat       = true
    nat = var.vm_web_nat
  }

  #   metadata = {
  #     serial-port-enable = var.vm_db_serial_port
  #     ssh-keys           = "ubuntu:${var.vms_ssh_root_key}"
  #   }
  metadata = var.metadata
}

resource "yandex_compute_instance" "platform-db" {
  ##name        = var.vm_db_name
  name = local.name-db

  platform_id = var.vm_db_platform
  zone        = var.vm_db_zone

  resources {
    #     cores         = var.vm_db_cores
    #     memory        = var.vm_db_memory
    #     core_fraction = var.vm_db_fraction
    cores         = var.vms_resources.db.cores
    memory        = var.vms_resources.db.memory
    core_fraction = var.vms_resources.db.core_fraction

  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }
  scheduling_policy {
    preemptible = var.vm_db_preemptible
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop_db.id
    nat       = var.vm_db_nat
  }

  #   metadata = {
  #     serial-port-enable = var.vm_db_serial_port
  #     ssh-keys           = "ubuntu:${var.vms_ssh_root_key}"
  #   }
  metadata = var.metadata
}
