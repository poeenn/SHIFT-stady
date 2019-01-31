# memo
SHIFT用のメモ
___
## 依頼内容
5台分のNW構成図等々設備設計資料を作成すること。  
またHW導入後以下を実施すること。  
1. CentOS minimalインストールと必要updateとinstall  
1. NW設定  
1. sudo権限グループとメンバsudo権限は別途誰に与えるか決める。  
1. 5ノードSSH導通　1台コントローラを決める。コントローラから他の4台へSSHできればよい。
1. git,Ansible,pipインストール　Ansibleはpyenvベース。
1. 社長からの依頼作業　別途連絡するらしい。細かい話は別途。  
１と５以降は外が必要なので別途Wifi貸してくれるらしい。

## 設計書
- 構成図
  - 物理＋論理構成図？なにやら検討しているようなので、それを図にする？
  - [これ](https://www.draw.io/)使って書く（タダで使える！？）
- ラック搭載図
- hostname決める
- ユーザ一覧
  - githubのユーザ名でよいと思う
- NETGEARのSWの環境設定（VLANとかPW）
  - マニュアルは[ここ](https://www.downloads.netgear.com/files/answer_media/jp/support/switch/manual/GS7xxT_SWA_J.pdf)
- IPアドレス一覧
- PP一覧？→必要であれば


## 構築＋その他
1. CentOS minimalインストールと必要updateとinstall  
    - CentOSの入手→CDかUSBか外付けHDD？そもそもCDドライブは搭載されていない・・・  
      - [Cisco Integrated Management Interface（CIM）](https://www.cisco.com/c/ja_jp/products/servers-unified-computing/ucs-c-series-integrated-management-controller/index.html)というのがあるらしい・・・サーバに付属している？  
    - [cisco C240 M5インストールガイド](https://www.cisco.com/c/ja_jp/td/docs/unified_computing/ucs/c/hw/C240M5/install/C240M5/C240M5_chapter_01.html)
    - テプラ作成、ケーブルの用意と内職、ラックマウント用のレール作る
    - ラッキングする
2. NW設定  
    - sshdの設定　→　permit root loginとかとか
3. sudo権限グループとメンバsudo権限は別途誰に与えるか決める。  
    - ユーザ作成とsudoの設定（sudoers）  
    設定方法は適当にググればでてくる[こことか](https://qiita.com/Esfahan/items/a159753d156d23baf180)[こことか](https://www.server-world.info/query?os=CentOS_7&p=initial_conf&f=8)
4. 5ノードSSH導通　1台コントローラを決める。コントローラから他の4台へSSHできればよい。
    - hostsに設定してpingとSSHで疎通確認
5. git,Ansible,pipインストール　Ansibleはpyenvベース。
    - yumで入れるがAnsibleは[別の入れ方](https://qiita.com/ksugawara61/items/ba9a51ebfdaf8d1a1b48)で入れる。

