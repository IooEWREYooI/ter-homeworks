output "task4" {
  value = <<EOT
    Instance name: ${yandex_compute_instance.platform.name}    IP: ${yandex_compute_instance.platform.network_interface.0.nat_ip_address}    FQDN: ${yandex_compute_instance.platform.fqdn}
    Instance name: ${yandex_compute_instance.platform-db.name}     IP: ${yandex_compute_instance.platform-db.network_interface.0.nat_ip_address}   FQDN: ${yandex_compute_instance.platform-db.fqdn}
  EOT
}
