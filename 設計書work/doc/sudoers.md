sudo権限はすべてのユーザに付与しないので、sudoersの設定をする。  

## wheel
sudoを許可するグループはデフォルトのwheelにする。  
`%wheel  ALL=(ALL)       ALL`  

## ansible実行ユーザ制限
ansible実行ユーザは対話形式での入力をさせないためにsudoでのパスワードは不要にする。  
`ansible ALL=(ALL) NOPASSWD:ALL`  

sudoユーザ以外からスイッチさせないようにwheelグループに許可するコマンドを指定する。  
`%wheel  ALL=(ALL) /usr/bin/su - ansible`  

