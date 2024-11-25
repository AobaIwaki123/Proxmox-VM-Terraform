resource "proxmox_lxc" "basic" {
  target_node  = "pve02"
  hostname     = "lxc-basic"
  password     = "lxc_secret"
  unprivileged = true
  ostemplate   = "local:vztmpl/ubuntu-24.10-standard_24.10-1_amd64.tar.zst"
  ostype      = "ubuntu"

  ssh_public_keys = <<-EOT
    ecdsa-sha2-nistp521 AAAAE2VjZHNhLXNoYTItbmlzdHA1MjEAAAAIbmlzdHA1MjEAAACFBAFENRdM4NwJfgRO/MqntSOLZxSy0fTLkj0etUL/CnakA7gNI9YuZUYQxtGVa80Oc+6bZjT38Nd6Eico5RoRVAdlzwEEfQq+iy3v/W8c0ElybiSQmPIw7Mc7KaEyUhMb1LgmVleZYsEizJV/89/lNGvPVjUXkcEZsliIMROuFepQASUiuQ== iwakiaoiyou@AobaMacBookAir.local
  EOT

  cores = 1
  memory = "512"
  swap = "512"

  vmid = 240

  // Terraform will crash without rootfs defined
  rootfs {
    storage = "local-lvm"
    size    = "32G"
  }

  network {
    name   = "eth0"
    bridge = "vmbr0"
    ip     = "192.168.11.240/24"
    gw     = "192.168.11.1"
  }
}
