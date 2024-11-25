resource "proxmox_lxc" "basic" {
  target_node  = "pve02"
  hostname     = "lxc-basic"
  password     = "lxc_secret"
  unprivileged = true
  ostemplate   = "local:vztmpl/ubuntu-24.10-standard_24.10-1_amd64.tar.zst"

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
