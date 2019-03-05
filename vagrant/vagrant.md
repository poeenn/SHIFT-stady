参考サイト  
https://knowledge.sakura.ad.jp/2535/  
https://qiita.com/it__ssei/items/18d54746be2dac56988f  


* パッケージインストール
```
yum install -y epel-release
yum install -y qemu-kvm libvirt libvirt-devel gcc patch wget sclo-vagrant1 rsync
```
> libvirtのみで起動する場合（おためし用）
> ```
> yum install -y centos-release-scl
> scl enable sclo-vagrant1 bash
> ```

* vagrantパッケージのインストール
```
cd /tmp
wget https://releases.hashicorp.com/vagrant/2.2.4/vagrant_2.2.4_x86_64.rpm
yum -y install vagrant_2.2.4_x86_64.rpm
vagrant plugin install vagrant-kvm
```

* vagrant用のディレクトリ作成
```
mkdir vmcentos
cd vmcentos
pwd
```

* vagrant box addでひな形を持ってくる
```
vagrant box add centos7 http://cloud.centos.org/centos/7/vagrant/x86_64/images/CentOS-7-x86_64-Vagrant-1812_01.Libvirt.box
```



* virtualbox関連のパッケージインストール
```
cd /etc/yum.repos.d/
wget http://download.virtualbox.org/virtualbox/rpm/rhel/virtualbox.repo
cd ~/vmcentos
yum install -y dkms
yum update -y

yum install -y VirtualBox-6.0.x86_64
```

* setupシェルの実行
```
/usr/lib/virtualbox/vboxdrv.sh setup
```

* 初期設定
```
vagrant init centos7
```

* vagrantで作成するVMの設定ファイルを編集
```
cat << EOF > Vagrantfile
Vagrant.configure(2) do |config|
  config.vm.box = "centos7"
      config.vm.provider :libvirt do |domain|
      domain.memory = 2048
      domain.cpus = 2
      domain.driver = 'kvm'
  end
  config.vm.network "public_network", :bridge => "virbr0"
end
EOF
```

* VMの作成
```
vagrant up
```

* 終わったらvagrantsshでVMに入る
```
vagrant ssh
```

* 停止
```
vagrant halt
```

* ステータス確認
```
vagrant status
```

* 削除（???にはstatusで確認した名前を入れるデフォルトはdefault）
```
vagrant destroy ???
```
