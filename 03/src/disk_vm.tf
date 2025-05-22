resource "yandex_compute_disk" "hdd" {
  count = 3
  name  = "hdd-${count.index}"
  type       = "network-hdd"
  size       = 1
}


resource "yandex_compute_instance" "storage" {
  depends_on = [yandex_compute_disk.hdd]
  name        = "storage"

  platform_id = var.vm_platform

  resources {
    cores         = var.vms_resources.web.cores
    memory        = var.vms_resources.web.memory
    core_fraction = var.vms_resources.web.core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }

  dynamic "secondary_disk" {
    for_each = yandex_compute_disk.hdd
    content {
      disk_id = secondary_disk.value.id
    }

  }
  scheduling_policy {
    preemptible = var.vm_preemptible
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = var.vm_nat
    security_group_ids = toset([yandex_vpc_security_group.example.id])
  }
  metadata = local.metadata
}
