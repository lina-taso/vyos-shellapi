# vyos shell api scripts

- vyos上でコンフィグ修正とかするためのスクリプト

## set-firewall-IPaddrlist.sh

- firewall group network-group JP というネットワークグループにIPアドレスを登録するスクリプト
    - 標準入力のリダイレクトやパイプからアドレス一覧を受け取って登録する
    - JPノードを消してから登録し直すので既存の一覧は削除される

- How to use
    - リモートサーバでアドレス一覧を作成して、ssh経由で設定したり。

     cat list.txt | ssh -i ~/.ssh/id_rsa vyos@vyos 'sh set-firewall-IPaddrlist.sh'

