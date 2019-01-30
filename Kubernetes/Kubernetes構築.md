# Kubernetesの構築用メモ
OpenStackの構築がうまいこといかないので、とりあえずKubernetesだけを入れてみる。  
サーバはConohaVPSを使用する。
## IPアドレス
- master:  
XXX.XXX.XXX.XXX  
- worker:  
YYY.YYY.YYY.YYY  
  - [参考サイト](https://ops.jig-saw.com/techblog/virtualbox_centos_kubernetes/)  
-------------------------------
## 事前設定

### SELinuxの無効化
```
setenforce 0
sed -i -e "s/^SELINUX=enforcing$/SELINUX=disabled/g" /etc/selinux/config
```

### 各ホストの送信元IPアドレスを許可するように設定
- master
```
firewall-cmd --new-zone k8s --permanent
firewall-cmd --zone=k8s --set-target=ACCEPT --permanent 
firewall-cmd --add-source=YYY.YYY.YYY.YYY --zone=k8s --permanent
firewall-cmd --reload
```

- worker
```
firewall-cmd --new-zone k8s --permanent
firewall-cmd --zone=k8s --set-target=ACCEPT --permanent 
firewall-cmd --add-source=XXX.XXX.XXX.XXX --zone=k8s --permanent
firewall-cmd --reload
```

### masterとworkerのホスト名で名前解決できるようにhostsに設定する。（じゃないとwarningがでる）
※Kubernetesでの通信はサーバのhostnameを使用して通信するらしい。なので、hosts OR DNSで解決できるようにしてやる必要がある。
```
cat << EOT3 >> /etc/hosts 2>&1
XXX.XXX.XXX.XXX XXX-XXX-XXX-XXX
YYY.YYY.YYY.YYY YYY-YYY-YYY-YYY
EOT3
```

### SWAPの無効
kubeadm導入前に無効化する。（意味があるかは不明）  
永続化する場合は /etc/fstab を編集する。
```
swapoff -a
```

### Kubeadm dockerのインストール
```
yum -y install yum-utils device-mapper-persistent-data lvm2
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
yum -y install docker-ce

systemctl enable docker
systemctl start docker


echo 1 > /proc/sys/net/bridge/bridge-nf-call-ip6tables
sysctl -w net.bridge.bridge-nf-call-ip6tables=1
echo 1 > /proc/sys/net/bridge/bridge-nf-call-iptables
sysctl -w net.bridge.bridge-nf-call-iptables=1


cat << EOF > /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
exclude=kube*
EOF


yum -y install kubeadm --disableexcludes=kubernetes
systemctl enable kubelet
systemctl restart kubelet

```


## マスターノードで実施
`–apiserver-advertise-address`でマスターノードの固定IPアドレスを設定。また`-pod-network-cidr`でpodのサブネットを設定。  
今回は10.240.0.0/16を設定する（適当）。

```
kubeadm init --apiserver-advertise-address XXX.XXX.XXX.XXX --pod-network-cidr 10.240.0.0/16
```

成功すると以下が表示される。  
`kubeadm join {ip}:{port} -token {token} -discovery-token-ca-cert-hash sha256:{hash}`  
ワーカーノード作成時に必要なのでどこかにコピーしとく。  
（ワーカーで上記の行をコピペ実行）  


### kube configのコピー
```
export KUBECONFIG=/etc/kubernetes/admin.conf
kubectl get nodes
kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/bc79dd1505b0c8681ece4de4c0d86c5cd2643275/Documentation/kube-flannel.yml
```

### kubectl を実行してnode情報が表示されることを確認
※表示されればOK
```
kubectl get nodes
```

###クラスタネットワークの導入
Flannelを使用する。一応ConohaVPSでKubernetesを構築している手順で使用していたのが理由。

```
export KUBECONFIG=/etc/kubernetes/admin.conf
kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/bc79dd1505b0c8681ece4de4c0d86c5cd2643275/Documentation/kube-flannel.yml
```

### kubectl を実行してnodeのStatusがReadyになっていることを確認
```
kubectl get nodes
```

## workerノードを作成
以下のコマンドで作成するが、コマンドはマスターノード作成時に出てきたのをそのまま使う。
```
kubeadm join --token {token} {ip}:{port} --discovery-token-ca-cert-hash sha256:{hash}
```

### masterノードで結果確認
kubectlを実行してworkerのSTATUSがReadyと表示されていれば構築は成功。
```
kubectl get nodes
```

---
## dashbordコンテナ作成確認
Kubernetesはインストールできたっぽいがコンテナの作成方法がわからない。。。  
Dashboard用のコンテナが公開されているようなので、別途入れる。

[Kubernetes 1.10 Dashboard設定](https://qiita.com/sugimount/items/689b7cd172c7eaf1235f)

```
wget https://raw.githubusercontent.com/kubernetes/dashboard/master/aio/deploy/recommended/kubernetes-dashboard.yaml
kubectl create -f https://raw.githubusercontent.com/kubernetes/dashboard/master/aio/deploy/recommended/kubernetes-dashboard.yaml
```

