# ハードインストール手順
1. CentOS minimalインストールと必要updateとinstall
  - CDドライブ？かUSBメモリとかからインストールする。  
  インストールメディアは用意するor用意してもらう。  
  で yum -y update  

2. NW設定
  - L2SW
    - 管理用IPを振る  
    192.168.20.253/24
    - VLANの設定をする（マニュアル見た感じIPアドレス設定できなさそうあくまでもL2SW）  
    1-5ポート：VLAN10  
    6-10ポート：VLAN20  
    - 不使用ポートシャットダウン  
    11-16はshutdown
    - 管理画面ログインパスワード変更  
    デフォルトがpasswordなので変えとく  
- Linux
    - eth0とeth1にIPとか設定する。
    - 鍵の作成と配布
    - sshd_configの設定を変更する。  
    root直ログイン禁止  
    鍵で認証する  
    パスワード認証禁止　等々（詳細は別）  

3. sudo権限グループとメンバsudo権限は別途誰に与えるか決める。
  - ユーザ作成
    - githubアカウント名でユーザを作成する。  
      パスワードは一律同じものにする。  
      期限切れにしておく＃＃要確認＃＃  
      ansibleユーザを作成して鍵認証するようにしておく。[参考](https://qiita.com/komitomo/items/e78855fa1ccee1737ac7)
    - sudo権限はとりあえず自分と三井さん分だけ入れておく

4. 5ノードSSH導通　1台コントローラを決める。コントローラから他の4台へSSHできればよい。
  - #1（コントローラノード）からSSH接続できるか確認する  
　　IPアドレスはVLAN10とVLAN20のIPどちらも確認する  
　　ユーザはansibleで  

5. git,Ansible,pipインストール　Ansibleはpyenvベース
  - 詳細は別  
  [Ansible側で指定する方法参考](https://qiita.com/kinpira/items/f775b08884535e948213)  
  [公式](https://docs.ansible.com/ansible/2.4/python_3_support.html)





