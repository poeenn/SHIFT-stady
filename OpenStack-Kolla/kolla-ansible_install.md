# kolla-ansibleでOpenStackをインストールする
Kolla-ansibleを使用してOpenStackを2ノードにインストールしてみる。

## パッケージのインストール
```
yum install -y epel-release
yum install -y python-pip
pip install -U pip
yum install -y python-devel libffi-devel gcc openssl-devel libselinux-python
yum install -y ansible
pip install -U ansible
yum install -y git docker
```

## ネットワークマネージャーの無効化
```
systemctl stop NetworkManager
systemctl disable NetworkManager
systemctl restart network
systemctl enable network
```

## hostsの設定
```
cat << EOT3 >> /etc/hosts 2>&1
XXX.XXX.XXX.XXX controller
YYY.YYY.YYY.YYY conpute
EOT3
```

## ansible.cfgの編集
```
vi /etc/ansible/ansible.cfg
#[defaults]の直下に入れる
host_key_checking=False
pipelining=True
forks=100
validate_certs=False
```

## kolla-ansible のインストール
```
pip install kolla-ansible -I -U
git clone https://github.com/openstack/kolla-ansible -b stable/queens
cd kolla-ansible
pip install -r requirements.txt
python setup.py install
cd 
cp -r kolla-ansible/etc/kolla /etc/kolla/
cp kolla-ansible/ansible/inventory/* .
```


## ymlを編集
queensはインストールできるが、rockyはダメ（kolla-ansible -i multinode deployでエラーになる）  
```
vi /etc/kolla/globals.yml
 kolla_base_distro: "centos"
 kolla_install_type: "source"
 openstack_release: "queens"

#ダッシュボードアクセス用IP
 kolla_internal_vip_address: "XXX.XXX.XXX.XXX"
 network_interface: "eth0"
 neutron_external_interface: "eth1"
 enable_haproxy: "no"
 nova_compute_virt_type: "qemu"
```

## パスワード生成
```
kolla-genpwd
```

## 生成されたパスワードを変更する
変更しなくてもいいが、結局ymlを確認するはめになるので変更したほうがいい。
```
vi /etc/kolla/passwords.yml
 keystone_admin_password: passpass
```




## multinode用の定義ファイルを変更する
viで適当に変える（インストールするサービスとかノードとかで変更内容が変わる）
```
vi multinode
```




## kolla-ansible
```
kolla-ansible -i multinode bootstrap-servers
kolla-ansible -i multinode prechecks
kolla-ansible -i multinode deploy
```
Dockerのエラーが出た場合Docker関連パッケージを全部消す  
```
rpm -qa | grep docker
yum erase ......
```

OKならデプロイする
```
kolla-ansible post-deploy
```

## 完了したら以下のコマンドを実行してdemo用の環境を作成する
```
pip install python-openstackclient python-glanceclient python-neutronclient -I -U
. /etc/kolla/admin-openrc.sh
. /usr/share/kolla-ansible/init-runonce
#途中で聞かれるパスフレーズは何も入力せずエンターキー押下してOK
openstack server create \
    --image cirros \
    --flavor m1.tiny \
    --key-name mykey \
    --nic net-id=7ef37cde-26aa-4939-ae3f-9cb42666f4b5 \
    demo1
```

構築直後はPublicネットワーク(10.0.2.0/24)へのアクセス用のブリッジが未設定のため  
ホストOS上で以下を設定  
これにより、Publicネットワーク上のフローティングIPアドレスに対して、ホストからpingやsshが可能になる
```
ip addr add 10.0.2.1/24 dev br-ex
ip link set br-ex up
ip route add 10.0.2.0/24 dev br-ex
```

また、OpenStack上のインスタンスからインターネットにアクセスできるようにするために、  
ホストOS側にソースNATの設定を追加  
（Publicネットワークから送られてきたパケットはソースNATしてeth0のインタフェースから送信する設定）  

```
iptables -t nat -A POSTROUTING -o eth0 -s 10.0.2.0/24 -j MASQUERADE
```

## 一応ブラウザから管理画面見れるか確認
http://XXX.XXX.XXX.XXX



