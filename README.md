# Create Proxmox VM/LXC with Terraform

Proxmox上にTerraformを用いてVMまたはLXCを作成するための設定ファイル群。  
`proxmox provider`の`2.11`系はProxmox VEのバージョンアップに対応しておらず、`3.0.1`系は`Breaking Change`が入り、知見が少なかったため手探りで作成した。
一応、`terraform apply`でしばらく待てば`SSH`ができるところまでは動作確認が取れた。

# Version情報

- Ubuntu: 24.10
- Terraform: v1.9.8
- tfenv: 3.0.0
- Proxmox: 8.3.0
- proxmox provider: 3.0.1-rc5
-   https://github.com/Telmate/terraform-provider-proxmox.git

# Gettig Started

## Terraformのインストール

```sh
$ sudo make init
$ make install-tfenv
```

## Provider情報のコピー

```sh
$ make copy-provider
```

## VMテンプレートの作成

以下のコマンドをproxmoxのノード上で実行する
スクリプトは[こちら](https://qiita.com/ymbk990/items/bd3973d2b858eb86e334)を参考にしました。  
コピペ用は[こちら](./scripts/create-vm-template.sh)。

```bash
$ wget https://cloud-images.ubuntu.com/oracular/current/oracular-server-cloudimg-amd64.img -O ubuntu-24.10-server-cloudimg-amd64.img
# Base VM configuration
$ qm create 9200 --net0 virtio,bridge=vmbr0
$ qm importdisk 9200 ubuntu-24.10-server-cloudimg-amd64.img local-lvm
$ qm set 9200 --name ubuntu-24.10a
$ qm set 9200 --scsihw virtio-scsi-pci --virtio0 local-lvm:vm-9200-disk-0
$ qm set 9200 --boot order=virtio0
$ qm set 9200 --ide2 local-lvm:cloudinit
$ qm set 9200 --nameserver 127.0.0.53 --searchdomain localdomain
# Convert VM to VM Template
$ qm template 9200
```

## 目的毎にTerraformの設定ファイル(env)を作成する

- 初めてこのリポジトリを使う場合は、既存のenvを削除する

```sh
$ make clean-env # VM用
```

- 以下のコマンドでenvを作成する

```bash
$ make create-vm-env ENV_NAME=dev # VM用
$ make create-lxc-env ENV_NAME=dev # LXC(コンテナ)用
```

`envs/dev/terraform.tfvars`を適宜編集する
詳しい説明は、それぞれの雛形のREADMEを参照

- [Terraform環境の適用方法(VM)](./envs/example-vm/README.md)
- [Terraform環境の適用方法(LXC)](./envs/example-lxc/README.md)

# 参考

- [Proxmox VEとTerraformでインターン生に仮想マシンを払い出す話](https://qiita.com/ymbk990/items/bd3973d2b858eb86e334)

