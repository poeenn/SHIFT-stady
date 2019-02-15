デフォルトから変更する箇所のみ記載  

# sshd_config
* PermitRootLogin  
`no`  
デフォルトはYESだが、一般ユーザ作るので普通に考えてnoにしておく  
* PubkeyAuthentication  
`yes`  
* Match  
ansible実行ユーザへのSSHログイン時にパスワード認証ではなく、  
鍵で認証させたい＆SSHで直ログインできないようにユーザ指定で設定値を変える  
```
Match User ansible  
 PasswordAuthentication no  
 AuthorizedKeysFile .ssh/authorized_keys  
```

# 鍵認証
外部からのアクセスがないため、一般ユーザのログインはパスワード認証とする。  
ただし、Ansible実行ユーザに関してはパスワードなしの鍵認証方式とすることで、Ansible実行対象のホストへのSSHログイン時に対話形式での入力が必要ないようにする。  
鍵は以下の通り作成する。  

| パーミッション | 絶対パス                           | 内容                   |
|----------------|------------------------------------|------------------------|
| 700            | /home/ansible/.ssh/id_rsa.pub      | 公開鍵                 |
| 600            | /home/ansible/.ssh/id_rsa          | 秘密鍵                 |
| 600            | /home/ansible/.ssh/authorized_keys | 認証用に使用する公開鍵 |

# Cipher  
鍵の暗号アルゴリズムは`ecdsa256`にする。  
RSA2048はもはや古いらしい。RSAより少ないビット数で強固で速い。  
