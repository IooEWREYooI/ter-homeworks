locals {
  metadata = {
    serial-port-enable = 1
    ssh-keys = "ubuntu: ${file(var.ssh_key_path)}"
  }
}