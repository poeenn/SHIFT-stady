# ハードインストール手順
1. CentOS minimalインストールと必要updateとinstall
  - CDドライブ？かUSBメモリとかからインストールする。  
  インストールメディアは用意するor用意してもらう。  
  で yum -y update  

1. NW設定
  - L3SW
    - 管理用IPを振る  
    192.168.200.254/24
    - VLANの設定をする  
    1-5ポート：VLAN100  
    6-10ポート：VLAN200  
    - 不使用ポートシャットダウン  
    11-16はshutdown
- Linux
    - eth0とeth1にIPとか設定する。
    - 鍵の作成と配布
    - sshd_configの設定を変更する。  
    root直ログイン禁止  
    鍵で認証する  
    パスワード認証禁止　等々  

1. sudo権限グループとメンバsudo権限は別途誰に与えるか決める。
  - ユーザ作成
    - githubアカウント名でユーザを作成する。  
      パスワードは一律同じものにする。  
      期限切れにしておく＃＃要確認＃＃  
      ansibleユーザを作成して鍵認証するようにしておく。[参考](https://qiita.com/komitomo/items/e78855fa1ccee1737ac7)
    - sudo権限はとりあえず自分と三井さん分だけ入れておく

1. 5ノードSSH導通　1台コントローラを決める。コントローラから他の4台へSSHできればよい。
  - #1（コントローラノード）からSSH接続できるか確認する  
　　IPアドレスはVLAN100とVLAN200のIPどちらも確認する  
　　ユーザはansibleで  

1. git,Ansible,pipインストール　Ansibleはpyenvベース
  - ...



| 機器名       | インターフェース | IPアドレス      |
|--------------|------------------|-----------------|
| L3SW         | 管理用IP         | 192.168.200.254 |
| SHIFT_bear#1 | eth0             | 10.0.10.1       |
| SHIFT_bear#2 | eth0             | 10.0.10.2       |
| SHIFT_bear#3 | eth0             | 10.0.10.3       |
| SHIFT_bear#4 | eth0             | 10.0.10.4       |
| SHIFT_bear#5 | eth0             | 10.0.10.5       |
| SHIFT_bear#1 | eth1             | 192.168.20.1    |
| SHIFT_bear#2 | eth1             | 192.168.20.2    |
| SHIFT_bear#3 | eth1             | 192.168.20.3    |
| SHIFT_bear#4 | eth1             | 192.168.20.4    |
| SHIFT_bear#5 | eth1             | 192.168.20.5    |
| k8s_master#1 | eth0             | 172.16.30.1     |
| k8s_node#1   | eth0             | 172.16.30.2     |
| k8s_node#2   | eth0             | 172.16.30.3     |
| k8s_master#1 | フローティングIP | 10.0.10.101     |
| k8s_node#1   | フローティングIP | 10.0.10.102     |
| k8s_node#2   | フローティングIP | 10.0.10.103     |
| 仮想ルータ   | external         | 10.0.10.254     |
| 仮想ルータ   | private          | 172.16.30.254   |
