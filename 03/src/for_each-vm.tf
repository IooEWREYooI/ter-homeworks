variable "each_vm" {
  default = [
    {
      vm_name     = "main"
      cpu         = 2
      ram         = 1
      disk_volume = 6
    },
    {
      vm_name     = "replica"
      cpu         = 2
      ram         = 2
      disk_volume = 8
  }]
}

resource "yandex_compute_instance" "db" {
  for_each = { for vm in var.each_vm : vm.vm_name => vm }

  name     = "db-${each.key}"
  hostname = "db-${each.value.vm_name}"

  platform_id = var.vm_platform

  resources {
    cores         = each.value.cpu
    memory        = each.value.ram
    core_fraction = 5
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
      type     = "network-hdd"
      size     = each.value.disk_volume
    }
  }
  scheduling_policy {
    preemptible = var.vm_preemptible
  }
  network_interface {
    subnet_id          = yandex_vpc_subnet.develop.id
    nat                = var.vm_nat
    security_group_ids = toset([yandex_vpc_security_group.example.id])
  }
  metadata = local.metadata
}
