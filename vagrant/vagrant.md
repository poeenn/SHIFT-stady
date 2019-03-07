* 参考サイト  
https://knowledge.sakura.ad.jp/2535/  
https://qiita.com/it__ssei/items/18d54746be2dac56988f  

* パッケージインストール
```
yum install -y epel-release
yum install -y qemu-kvm libvirt libvirt-devel gcc patch wget rsync
yum -y install libguestfs libguestfs-tools libguestfs-tools-c libvirt libvirt-client python-virtinst qemu-kvm virt-manager virt-top virt-viewer
yum update -y

```

> * libvirtのみで起動する場合（おためし用）
> ```
>  yum install -y centos-release-scl
>  scl enable sclo-vagrant1 bash
> 
> ```

* vagrantパッケージのインストール
```
 cd /tmp
 wget https://releases.hashicorp.com/vagrant/2.2.4/vagrant_2.2.4_x86_64.rpm
 yum -y install vagrant_2.2.4_x86_64.rpm
 vagrant plugin install vagrant-kvm
 vagrant plugin install vagrant-libvirt

```


* vagrant用のディレクトリ作成
```
 mkdir ~/vmcentos
 cd ~/vmcentos
 pwd

```



* 仮想化支援機能の有効化確認  
  Intel系OSなのでvmxでgrepしてなんかでたら対応している  
```
cat /proc/cpuinfo | grep vmx

```

* kvmのネストを有効にする
```
echo options kvm_intel nested=1 >> /etc/modprobe.d/kvm-nested.conf
modprobe -r kvm_intel
modprobe  kvm_intel
cat /sys/module/kvm_intel/parameters/nested

```





* vagrant box addでひな形を持ってくる
```
 vagrant box add centos/7

```

* libvirtdの再起動と自動起動設定
```
systemctl start libvirtd
systemctl enable libvirtd
```


> * virtualbox関連のパッケージインストール
> ```
> cd /etc/yum.repos.d/
>  wget http://download.virtualbox.org/virtualbox/rpm/rhel/virtualbox.repo
>  cd ~/vmcentos
>  yum install -y dkms
>  yum install -y VirtualBox-6.0.x86_64
> 
> ```

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
  config.vm.define :centos do |v|
    v.vm.box = "centos/7"
    v.vm.hostname = "vagrant"

    v.vm.provider :libvirt do |domain|
       domain.memory = 2048
       domain.cpus = 2
     end

    v.vm.network :public_network,
       :dev => "virbr0",
       :mode => "bridge",
       :type => "bridge",
       libvirt__network_name: 'net1'
  end
end
EOF

```


* VMの作成
```
 vagrant up --provider=libvirt

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
