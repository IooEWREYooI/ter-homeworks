data "yandex_compute_image" "ubuntu" {
  family = var.vm_family
}

resource "yandex_compute_instance" "web" {
  depends_on = [yandex_compute_instance.db]

  count=2
  name        = "web-${count.index+1}"
  hostname    =  "web-${count.index+1}"

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
