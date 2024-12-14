# Create Proxmox VM/Container with Terraform

Proxmox上にTerraformを用いてVMまたはContainerを作成するための設定ファイル群。  
`proxmox provider`の`2.11`系はProxmox VEのバージョンアップに対応しておらず、`3.0.1`系は`Breaking Change`が入り、知見が少なかったため手探りで作成した。
一応、`terraform apply`でしばらく待てば`SSH`ができるところまでは動作確認が取れた。

# Version情報

- Ubuntu: 24.10
- Terraform: v1.9.8
- tfenv: 3.0.0
- Proxmox: 8.3.0
- [proxmox provider](https://github.com/Telmate/terraform-provider-proxmox): 3.0.1-rc6
  - Containerに関しては、`rc5`, `rc6`において[こちら](https://github.com/Telmate/terraform-provider-proxmox/issues/1172)のISSUEが存在するため、`rc4`を使用している
  - https://registry.terraform.io/providers/Telmate/proxmox/latest/docs
 
# Gettig Started

## Provider情報のコピー

```sh
$ make copy-provider
```

## 目的毎にTerraformの設定ファイル(env)を作成する

- 初めてこのリポジトリを使う場合は、既存のenvを削除する

```sh
$ task delete-all-envs
```

- 以下のコマンドでenvを作成する

```bash
$ task create-vm -- VM_NAME
$ task create-container -- CT_NAME
```

`envs/dev/terraform.tfvars`を適宜編集する
詳しい説明は、それぞれの雛形のREADMEを参照

# Docs

- [Terraformのインストール](./docs/install_terraform.md)
- [VMテンプレートの作成](./docs/create_vm_template.md)
- 

