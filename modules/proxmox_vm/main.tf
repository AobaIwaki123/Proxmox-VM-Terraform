resource "proxmox_vm_qemu" "vm" {
  name       = "${var.username}-${var.ip_address}"
  target_node = var.target_node
  clone       = var.template
  os_type     = "cloud-init"
  boot        = "order=virtio0"

  cores   = var.cores
  memory  = var.memory

  disk {
    storage = var.storage
    type    = "virtio"
    size    = "${var.disk_size}G"
  }
  
  network {
    model    = "virtio"
    bridge   = var.bridge
    firewall = false
  }

  ipconfig0 = "ip=${var.ip_address}/24,gw=${var.gateway}"
  ciuser    = var.username
  sshkeys   = var.public_key
}
