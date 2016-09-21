# vyos shell api scripts

vyos上でコンフィグ修正とかするためのスクリプトとその関連スクリプト

- ローカル：VyOSが動いているサーバを指します
- リモート：SSHなどでVyOSに接続する手元PCなどを指します


## set-firewall-IPaddrlist.sh

`firewall group network-group JP`というネットワークグループにIPアドレスを登録するスクリプト

- 標準入力のリダイレクトやパイプからアドレス一覧を受け取って登録する
- JPノードを消してから登録し直すので既存の一覧は削除される

### How to use

- リモートサーバでアドレス一覧を作成して、ssh経由で設定したり。
    cat list.txt | ssh -i ~/.ssh/id_rsa vyos@vyos 'sh set-firewall-IPaddrlist.sh'

- ローカルのテキストファイル読み込んで設定したり。
    sh set-firewall-IPaddrlist.sh < ipaddr.txt


## get-JP-IPaddrlist.sh

APNICのIPアドレスアサインリストを取得して、IPアドレス（ネットワークアドレス）一覧を取得するスクリプト

- http://ftp.apnic.net/stats/apnic/delegated-apnic-latest からIPv4のアサイン情報を読み取って、IPアドレス一覧を生成
- その後、`set-firewall-IPaddrlist.sh`に読み込ませる
- ローカルで実行することを想定
  - スクリプトを書き換えればSSH経由でもできそう

### How to use

- 実行するだけ。
    sh get-JP-IPaddrlist.sh

### Appendix

- VyOS上のtask-schedularに突っ込めば自動でJPのリスト更新
    task JP-update {
        crontab-spec "0 3 1 * *"
        executable {
            path /path/to/get-JP-IPaddrlist.sh
        }
    }
