wget https://cloud-images.ubuntu.com/oracular/current/oracular-server-cloudimg-amd64.img -O ubuntu-24.10-server-cloudimg-amd64.img
qm create 9300 --net0 virtio,bridge=vmbr0
qm importdisk 9300 ubuntu-24.10-server-cloudimg-amd64.img local-lvm
qm set 9300 --name ubuntu-24.10a
qm set 9300 --scsihw virtio-scsi-pci --virtio0 local-lvm:vm-9300-disk-0
qm set 9300 --boot order=virtio0
qm set 9300 --ide2 local-lvm:cloudinit
qm set 9300 --nameserver 127.0.0.53 --searchdomain localdomain
qm template 9300
