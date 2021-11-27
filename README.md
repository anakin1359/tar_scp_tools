# tar_scp_tools

1. expectをインストール
```
yum install -y expect
```

2. 変数の指定
* dest_dir: 転送先のディレクトリ（絶対パス）
* dest_ip:  転送先ホストのIP
* dest_pw:  転送先ホストに接続するためのパスワード

3. cronの設定
* crontabの編集
```
vim /var/spool/cron/root
```

* 毎週月曜日のAM2時30分に実行
```
30 2 * * 1 /root/script_tools/tar_scp_tools.sh > /dev/null 2>&1
```

* 設定したcron、及びcrondの状態を確認
```
systemctl status crond && echo "--------" && crontab -l
```