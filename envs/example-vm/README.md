# Terraform環境の適用方法(VM)

## 事前準備

```sh
$ pwd # envs/exampleにいることを確認
~/terraform/envs/example
$ make tf-init
```

## 環境の作成

```sh
$ make tf-apply
```

## 環境の削除

```sh
$ make tf-destroy
```

## 環境のリセット

```sh
$ make tf-reset
```

## 指定できるパラメータ

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
