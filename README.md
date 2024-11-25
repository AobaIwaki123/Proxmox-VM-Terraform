# Create Proxmox VM with Terraform

Proxmox上にTerraformを用いてVMを作成するための設定ファイル群。  
`proxmox provider`の`2.11`系はProxmox VEのバージョンアップに対応しておらず、`3.0.1`系は`Breaking Change`が入り、知見が少なかったため手探りで作成した。
一応、`terraform apply`でしばらく待てば`SSH`ができるところまでは動作確認が取れた。

# Version情報

- Ubuntu (OS Template): 24.10
- Terraform: v1.9.8
- tfenv: 3.0.0
- Proxmox: 8.3.0
- proxmox provider: 3.0.1-rc5

# Gettig Started

## Terraformのインストール

```sh
$ sudo make init # 必要なapt packageのインストール
$ make install-tfenv # tfenvのインストール
```

## Proxmox API Tokenの取得

Tokenの作成手順については、[こちら](https://qiita.com/ymbk990/items/bd3973d2b858eb86e334#api%E3%83%88%E3%83%BC%E3%82%AF%E3%83%B3%E3%81%AE%E5%8F%96%E5%BE%97)を参考にしました。

```sh
$ pvesh create /access/users/root@pam/token/sample --privsep 0
┌──────────────┬──────────────────────────────────────┐
│ key          │ value                                │
╞══════════════╪══════════════════════════════════════╡
│ full-tokenid │ root@pam!sample                      │
├──────────────┼──────────────────────────────────────┤
│ info         │ {"privsep":"0"}                      │
├──────────────┼──────────────────────────────────────┤
│ value        │ ed1c77c5-3738-43d0-bd07-ffc7b25977fd │
└──────────────┴──────────────────────────────────────┘
```

## Provider情報のコピー

```sh
$ make copy-provider
# modules/proxmox_vm/provider.tfが作成される
```

`provider.tf`にProxmox API Tokenの情報を記述する

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
$ make clean-env
```

- 以下のコマンドでenvを作成する

```bash
$ make create-env ENV_NAME=dev
```

`envs/dev/terraform.tfvars`を適宜編集する
以下はざっくりした説明

- hostname : VMのホスト名
- username : VMにログインするユーザ名
- public_key : VMにログインするための公開鍵
- cores : CPUのコア数
- memory : メモリのサイズ (MB)
- disk_size : ディスクのサイズ (GB)
- ip_address : VMに割り当てるIPアドレス
- gateway : VMに割り当てるゲートウェイ
- target_node : Proxmoxのノード名
- template : VMのテンプレート名
- storage : VMのストレージ名
- bride : VMに割り当てるネットワークブリッジ
- vmid : VMのID

## Terraform環境の適用方法

```sh
$ cd envs/dev
$ make tf-init
$ make tf-apply
```

[こちら](./envs/example/README.md)に詳しい手順が記載されています。

# 参考

- [Proxmox VEとTerraformでインターン生に仮想マシンを払い出す話](https://qiita.com/ymbk990/items/bd3973d2b858eb86e334)

