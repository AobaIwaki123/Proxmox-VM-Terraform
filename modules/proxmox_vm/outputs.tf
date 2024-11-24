output "vm_name" {
  value = proxmox_vm_qemu.vm.name
}
output "vm_id" {
  value = proxmox_vm_qemu.vm.id
}
output "ip_address" {
  value = var.ip_address
}
