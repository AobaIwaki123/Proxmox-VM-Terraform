# Create Proxmox VM/Container with Terraform

自前のProxmox環境にVMやコンテナを立てるためのTerraformフレームワーク。  
基本的なコマンドは、Taskfileに集約し、基礎となる環境ファイルは`template`ディレクトリに格納している。  
公式のドキュメントは[こちら](https://registry.terraform.io/providers/Telmate/proxmox/latest/docs/guides/cloud-init%2520getting%2520started)。  
絶賛`3.0.1`開発中のProxmox Providerのリポジトリは[こちら](https://github.com/Telmate/terraform-provider-proxmox)。

# Version情報

- Ubuntu: 24.10
- Terraform: v1.9.8
- tfenv: 3.0.0
- Proxmox: 8.3.0
- proxmox provider: 3.0.1-rc6
  - Containerに関しては、`rc5`, `rc6`において[こちら](https://github.com/Telmate/terraform-provider-proxmox/issues/1172)のISSUEが存在するため、`rc4`を使用している
 
# Gettig Started

## Provider情報のコピー

- TOKENをべたがきするようになっているため、流出に注意

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
